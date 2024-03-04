#import "Debug.h"

@interface Debug()
@end
@implementation Debug
+ (void) alter:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"企业微信"
                    message:msg
                    delegate:nil
                    cancelButtonTitle:@"确定"
                    otherButtonTitles:nil];
    [alert show];
}

+ (void) log:(NSString *)msg {
    NSLog(@"[FJHDebug] %@", msg);
}
@end