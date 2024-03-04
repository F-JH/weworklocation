#import "src/FJHLocationManager.h"
@interface FJHLocationManager()
@end
@implementation FJHLocationManager
static FJHLocationManager * _shareInstance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[super allocWithZone:NULL] init];
    });
    return _shareInstance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [FJHLocationManager shareInstance];
}
+ (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [FJHLocationManager shareInstance];
}
@end