# 手动重签名脚本
if [ ! -n "$2" ]; then
  echo "Usage: ./resign.sh app.ipa ./embedded.mobileprovision \n\tor ./resign.sh xxx.app ./embedded.mobileprovision"
  exit 1
fi

# 重签目标后缀
resign_obj=(dylib so 0 vis pvr framework appex app)
# 需要修改包名的插件
rename_obj=(appex app)

BUILD_DIR=build
KEYVALUE=`security find-identity -v -p codesigning | sed -n '1p'  | awk -F "\"" '{print $1}' | awk '{print $2}'`
KEYNAME=`security find-identity -v -p codesigning | sed -n '1p'  | awk -F "\"" '{print $2}'`
SUFFIX=`echo $1 | awk -F '.' '{print $NF}'`

if [ ! -d "$BUILD_DIR" ]; then
  mkdir $BUILD_DIR
fi


case $SUFFIX in
  ipa)
    unzip -qd $BUILD_DIR/ $1
    ;;
  app)
    mkdir $BUILD_DIR/Payload
    cp -r $1 $BUILD_DIR/Payload/
    ;;
  *)
    echo "暂不支持除.ipa和.app以外的项目重签名"
    exit 1
esac

APPNAME=`ls $BUILD_DIR/Payload/`
BUNDLEEXECUTABLE=`/usr/libexec/PlistBuddy -c 'Print CFBundleExecutable' $BUILD_DIR/Payload/$APPNAME/Info.plist`
# /usr/libexec/PlistBuddy -x -c 'Delete CFBundleREsourceSpecification' $BUILD_DIR/Payload/$APPNAME/Info.plist
BUNDLEIDENTIFIER=`/usr/libexec/PlistBuddy -c "Print :'CFBundleIdentifier'" $BUILD_DIR/Payload/$APPNAME/Info.plist`
# 解析embedded.mobileprovision位置
if [ ! -z "$2" ]; then
  EMBEDDED=$2
else
  EMBEDDED=./embedded.mobileprovision
fi
echo KEYNAME: $KEYNAME
echo KEYVALUE: $KEYVALUE
echo APPNAME: $APPNAME
echo EMBEDDED: $EMBEDDED
echo BUNDLEIDENTIFIER: $BUNDLEIDENTIFIER

echo "生成权限相关的plist文件"
cp $EMBEDDED $BUILD_DIR/Payload/$APPNAME/embedded.mobileprovision
security cms -D -i $EMBEDDED > $BUILD_DIR/ProvisioningProfile.plist
/usr/libexec/PlistBuddy -x -c 'Print Entitlements' $BUILD_DIR/ProvisioningProfile.plist > $BUILD_DIR/entitlements.plist
/usr/libexec/PlistBuddy -c 'Print ExpirationDate' $BUILD_DIR/ProvisioningProfile.plist | xargs -I {} $BUILD_DIR/transTime "{}" > $BUILD_DIR/Payload/$APPNAME/myExpirationDate.txt

user_identifier=`/usr/libexec/PlistBuddy -c "Print application-identifier" $BUILD_DIR/entitlements.plist | awk -F '.' '{print $1}'`
TARGET_BUNDLEIDENTIFIER=`/usr/libexec/PlistBuddy -c "Print application-identifier" $BUILD_DIR/entitlements.plist | sed s/$user_identifier.//g`
mv $BUILD_DIR/entitlements.plist $BUILD_DIR/Payload/
rm $BUILD_DIR/ProvisioningProfile.plist
echo user_identifier: $user_identifier
echo TARGET_BUNDLEIDENTIFIER: $TARGET_BUNDLEIDENTIFIER
chmod 755 $BUILD_DIR/Payload/$APPNAME/$BUNDLEEXECUTABLE
cd $BUILD_DIR/Payload/

# 改包名
echo "修改包名"
for i in "${rename_obj[@]}" ; do
  app_dirs=()
  while IFS= read -r line; do
    app_dirs+=($line)
  done < <(find $APPNAME -name "*.$i")
  for app_dir in "${app_dirs[@]}" ; do
    origin_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $app_dir/Info.plist`
    origin_displayname=`/usr/libexec/PlistBuddy -c "Print CFBundleDisplayName" $app_dir/Info.plist`
    target_identifier=`echo $origin_identifier | sed s/$BUNDLEIDENTIFIER/$TARGET_BUNDLEIDENTIFIER/g`
    echo "change bundle identifier [$origin_identifier] to [$target_identifier]"
    /usr/libexec/PlistBuddy -c "Set :'CFBundleIdentifier' '$target_identifier'" $app_dir/Info.plist
    /usr/libexec/PlistBuddy -c "Set :'CFBundleDisplayName' '$origin_displayname.Joyy'" $app_dir/Info.plist
  done
done

# 重签 & 删除原项目的 CFBundleREsourceSpecification
/usr/libexec/PlistBuddy -x -c 'Delete CFBundleREsourceSpecification' $APPNAME/Info.plist
for i in "${resign_obj[@]}" ; do
  case $i in
    app | appex)
      echo "codesign app/appex"
      obj_app=()
      while IFS= read -r line; do
        obj_app+=($line)
      done < <(find $APPNAME -name "*.$i")
      for j in "${obj_app[@]}" ; do
        /usr/libexec/PlistBuddy -c 'Print CFBundleExecutable' $j/Info.plist | xargs -I {} codesign -f -s $KEYVALUE --generate-entitlement-der --entitlements=./entitlements.plist $j/{}
        /usr/libexec/PlistBuddy -c 'Print CFBundleExecutable' $j/Info.plist | xargs -I {} echo "CFBundleExecutable is {}"
      done
      ;;
    framework)
      echo "codesign framework"
      obj_framework=()
      while IFS= read -r line; do
        obj_framework+=($line)
      done < <(find $APPNAME -name "*.$i")
      for k in "${obj_framework[@]}" ; do
        echo $k | awk -F '/' '{print $NF}' | awk -F '.' '{print $1}' | xargs -I {} codesign -f -s $KEYVALUE --generate-entitlement-der --entitlements=./entitlements.plist $k/{}
      done
      ;;
    *)
      find $APPNAME -name "*.$i" | xargs -I {} codesign -f -s $KEYVALUE --generate-entitlement-der --entitlements=./entitlements.plist {}
  esac
done

rm entitlements.plist
cd ..

echo "打包ipa"
zip -qry $BUNDLEEXECUTABLE.ipa Payload
rm -rf Payload