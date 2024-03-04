#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN
@interface FJHLocationManager : NSObject
// 地理位置：
@property (nonatomic, strong) CLLocation *location;
// 地理经纬度：
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
// 记录插件是否打开的开关：
@property (nonatomic, assign) BOOL isOpen;
// 初始化主界面右上角小菜单
@property (nonatomic, strong) id items;
+ (instancetype)shareInstance;
@end
NS_ASSUME_NONNULL_END