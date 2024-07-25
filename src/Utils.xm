#import "Utils.h"

bool isCallFromOrigin(){
    NSArray *address = [NSThread callStackReturnAddresses];
    Dl_info info = {0};
    if(dladdr((void *)[address[2] longLongValue], &info) == 0) return false;
    NSString *path = [NSString stringWithUTF8String:info.dli_fname];
    if ([path hasPrefix:NSBundle.mainBundle.bundlePath]) {
        //  二进制来自 ipa 包内
        if ([path.lastPathComponent isEqualToString:@"weworklocationhook.dylib"]) {
            //  二进制是插件本身
            return false;
        } else {
            //  二进制是程序本源
            return true;
        }
    } else {
        //  二进制是系统或者越狱插件
        return false;
    }
}