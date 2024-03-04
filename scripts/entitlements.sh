# 制作entitlements.plist
security cms -D -i embedded.mobileprovision > build/temp.plist
/usr/libexec/PlistBuddy -x -c 'Print :Entitlements' build/temp.plist > build/entitlements.plist