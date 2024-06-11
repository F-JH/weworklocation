TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard

# C++
CC=g++
CFLAGS=-c -Wall
BUILD_DIR=build
SOURCES=$(wildcard src/*.cpp)
OBJ=$(addprefix build/,$(notdir $(SOURCES)))
OBJECTS=$(OBJ:.cpp=.o)
EXECUTABLE=transTime

$(BUILD_DIR):
	@if [ ! -d "$(BUILD_DIR)" ]; then mkdir -p $(BUILD_DIR); fi

time: $(BUILD_DIR) cleanO $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(BUILD_DIR)/$@

build/%.o: src/%.cpp
	$(CC) $(CFLAGS) $< -o $@

cleanO:
	rm -rf $(BUILD_DIR)/*.o
# normal

export THEOS_DEVICE_IP = 127.0.0.1
export THEOS_DEVICE_PORT = 2222
export THEOS_DEVICE_USER = root

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = weworklocationhook

SRC_FILES = $(wildcard src/*.m)

#CLLocationManagerDelegate-Protocol.x
weworklocationhook_FILES = Tweak.x $(SRC_FILES)
weworklocationhook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

DYLIB=.theos/obj/debug/weworklocationhook.dylib
CERT=certificate/embedded.mobileprovision

.PHONY: check_package
check_package:
	@if [ ! -f $(DYLIB) ]; then \
  		$(MAKE) all debug=0; \
  	else \
  		echo "$(DYLIB) already exists, skipping package target."; \
  	fi

cleanPkg:
	rm -rf packages/*
	rm -rf build/*
	rm -rf var/*
	rm -rf $(CERT)

inject:
	scripts/injection.sh app/企业微信.ipa

buildIpa: cleanPkg $(CERT) check_package time inject
	scripts/resign.sh var/Payload/wework.app certificate/embedded.mobileprovision
	rm -rf var/*


installIpa: buildIpa
	ideviceinstall -i build/wework.ipa

test: package
	@echo "test"

$(CERT):
	@cert_file=$$(ls -l ~/Library/MobileDevice/Provisioning\ Profiles | grep -v '^total' | awk '{print $$NF}'); \
  	cp ~/Library/MobileDevice/Provisioning\ Profiles/$$cert_file $@
