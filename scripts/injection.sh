# 注入dylib脚本
if [ ! -n "$1" ]; then
  echo "Usage: ./injection.sh app.ipa"
  exit 1
fi
# 检查theos
if [ -z "$THEOS" ]; then
  if [ ! -d "/opt/theos" ]; then
    echo "Could not find THEOS, please confirm your theos is installed."
    exit 1
  else
    THEOS=/opt/theos
  fi
fi


BUILD_DIR=var

if [ ! -d "$BUILD_DIR" ]; then
  mkdir $BUILD_DIR
fi
unzip -qd $BUILD_DIR/ $1
APPNAME=`ls $BUILD_DIR/Payload/ | awk -F '.' '{print $1}'`

cp $THEOS/lib/libsubstrate.dylib $BUILD_DIR/
cp .theos/obj/debug/weworklocationhook.dylib $BUILD_DIR/
install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @executable_path/Frameworks/libsubstrate.dylib $BUILD_DIR/weworklocationhook.dylib
optool install -c load -p @executable_path/Frameworks/weworklocationhook.dylib -t $BUILD_DIR/Payload/$APPNAME.app/$APPNAME
mv $BUILD_DIR/*.dylib $BUILD_DIR/Payload/$APPNAME.app/Frameworks/
