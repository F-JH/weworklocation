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
    [FJHLocationManager shareInstance].QMUIPopupMenuViewObj = self;
    if ([[FJHLocationManager shareInstance].items count] != 0){
        // 已经初始化过
        items = [FJHLocationManager shareInstance].items;
    } else {
        // 获取证书过期时间
        NSString *expirationDate;
        NSString *expirationFilePath = [[NSBundle mainBundle] pathForResource:@"myExpirationDate" ofType:@"txt"];
        if (expirationFilePath) {
            NSError *error;
            expirationDate = [NSString stringWithContentsOfFile:expirationFilePath encoding:NSUTF8StringEncoding error:&error];
            // expirationDate = [Debug formatDate:txt];
            if (error) {
                expirationDate = @"Error reading file";
            }
        }else {
            expirationDate = @"File not found at path";
        }
        [FJHLocationManager shareInstance].expirationDate = expirationDate;

        // 未初始化
        [FJHLocationManager shareInstance].isOpen = false;
        NSMutableArray *newItems = [[NSMutableArray alloc] initWithArray:items];
        Class itemClass = NSClassFromString(@"QMUIPopupMenuButtonItem");
        id locationItem = [[itemClass alloc] init];
        [locationItem setValue:@"打开定位" forKey:@"title"];
        [locationItem setValue:[[items objectAtIndex:2] valueForKey:@"image"] forKey:@"image"];
        [locationItem setValue:^(id aItem){
            if ([FJHLocationManager shareInstance].isOpen) {
                [Debug alter:@"已恢复正常定位" title:@"虚拟定位"];
                [[[FJHLocationManager shareInstance].items objectAtIndex:4] setValue:@"打开定位" forKey:@"title"];
            } else {
                [Debug alter:@"已修改定位到公司" title:@"虚拟定位"];
                [[[FJHLocationManager shareInstance].items objectAtIndex:4] setValue:@"关闭定位" forKey:@"title"];
            }
            [FJHLocationManager shareInstance].isOpen = ![FJHLocationManager shareInstance].isOpen;
            [[FJHLocationManager shareInstance].QMUIPopupMenuViewObj hideWithAnimated:true];
        } forKey:@"handler"];

        // 增加查看过期时间
        id expirationDateItem = [[itemClass alloc] init];
        [expirationDateItem setValue:@"过期时间" forKey:@"title"];
        [expirationDateItem setValue:[[items objectAtIndex:2] valueForKey:@"image"] forKey:@"image"];
        [expirationDateItem setValue:^(id aItem){
            [Debug alter:[FJHLocationManager shareInstance].expirationDate title:@"当前证书过期时间"];
            [[FJHLocationManager shareInstance].QMUIPopupMenuViewObj hideWithAnimated:true];
        } forKey:@"handler"];

        [newItems addObject:locationItem];
        [newItems addObject:expirationDateItem];
        items = [NSArray arrayWithArray:newItems];
        [FJHLocationManager shareInstance].items = items;
    }
    %orig;
}

%end
