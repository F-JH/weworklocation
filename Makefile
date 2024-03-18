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




cleanPkg:
	rm -rf packages/*
	rm -rf build/*
	rm -rf var/*

inject:
	scripts/injection.sh app/企业微信.ipa

buildIpa: time cleanPkg package inject
	scripts/resign.sh var/Payload/wework.app certificate/embedded.mobileprovision
	rm -rf var/*

installIpa: buildIpa
	ideviceinstall -i build/wework.ipa
