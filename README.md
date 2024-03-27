ios企业微信hook (THEOS)

百度到的文章多为hook住WWKLocationRetrieverBaseTask以及WWKLocationRetriever这两个类，因为它们是CLLocationManagerDelegate的回调，
但经测试发现有的地方并没有通过这两个类去调用CLLocation，迫不得已干脆对CLLocationManager的startUpdatingLocation直接hook住，在这个方
法里直接调用didUpdateLocations去修改定位。

额外在主界面右上角的小菜单增加一个开关；

增加了重签名脚本，以及dylib注入脚本。分别是：
注入脚本：injection.sh
重签名脚本：resign.sh

注：注入脚本使用了optool，需要自行安装

1.安装theos依赖: https://liam.page/2023/01/19/Build-an-iOS-Jailbreak-Tweak-Install-Theos/

2.安装optool: https://github.com/alexzielenski/optool

3.把企业微信.ipa放到 app/ 目录下，证书文件放在 certificate/embedded.mobileprovision

4.直接编译并打包成ipa: make buildIpa 在build路径下找到重签后的ipa安装
