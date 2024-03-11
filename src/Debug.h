#import <UIKit/UIKit.h>
@interface Debug : NSObject

+ (void) alter:(NSString *)msg title:(NSString *)title;
+ (void) log:(NSString *)msg;
+ (NSString*) formatDate:(NSString *)date;

@end