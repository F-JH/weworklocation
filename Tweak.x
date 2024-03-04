#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

#import "src/Debug.h"
#import "src/FJHLocationManager.h"
#import "include/QMUIPopupMenuView.h"


%hook CLLocationManager

- (void)startUpdatingLocation {
    if ([FJHLocationManager shareInstance].isOpen) {
        CLLocation *CompanyLocation = [[CLLocation alloc] initWithLatitude:23.010666 longitude:113.342308];
        NSArray *locations = [[NSArray alloc] initWithObjects:CompanyLocation, nil];
        [self.delegate locationManager:self didUpdateLocations:locations];
    } else {
        %orig;
    }
}

%end

%hook QMUIPopupMenuView

- (void)setItems:(id)items {
    [Debug log:@"setItems"];
    FJHLocationManager *locationManager = [FJHLocationManager shareInstance];
    if ([locationManager.items count] != 0){
        // 已经初始化过
        items = locationManager.items;
    } else {
        // 未初始化
        locationManager.isOpen = false;
        NSMutableArray *newItems = [[NSMutableArray alloc] initWithArray:items];
        Class itemClass = NSClassFromString(@"QMUIPopupMenuButtonItem");
        id locationItem = [[itemClass alloc] init];
        [locationItem setValue:@"打开定位" forKey:@"title"];
        [locationItem setValue:[[items objectAtIndex:2] valueForKey:@"image"] forKey:@"image"];
        [locationItem setValue:^(id aItem){
            if ([FJHLocationManager shareInstance].isOpen) {
                [Debug alter:@"已恢复正常定位"];
                [[[FJHLocationManager shareInstance].items objectAtIndex:4] setValue:@"打开定位" forKey:@"title"];
            } else {
                [Debug alter:@"已修改定位到公司"];
                [[[FJHLocationManager shareInstance].items objectAtIndex:4] setValue:@"关闭定位" forKey:@"title"];
            }
            [FJHLocationManager shareInstance].isOpen = ![FJHLocationManager shareInstance].isOpen;
        } forKey:@"handler"];

        [newItems addObject:locationItem];
        items = [NSArray arrayWithArray:newItems];
        locationManager.items = items;
    }
    %orig;
}

%end
