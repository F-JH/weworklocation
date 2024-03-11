#import "Debug.h"

@interface Debug()
@end
@implementation Debug
+ (void) alter:(NSString *)msg title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                    message:msg
                    delegate:nil
                    cancelButtonTitle:@"确定"
                    otherButtonTitles:nil];
    [alert show];
}

+ (void) log:(NSString *)msg {
    NSLog(@"[FJHDebug] %@", msg);
}
// 将 Mon Mar 11 14:23:12 CST 2024 转化为 2024-03-11 14:23:11
+ (NSString*) formatDate:(NSString *)date {
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate* fmtDate = [fmt dateFromString:date];
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
	[outputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	[outputDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [outputDateFormatter stringFromDate:fmtDate];
}

@end