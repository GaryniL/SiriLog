THEOS_PACKAGE_DIR_NAME = debs
TARGET =: clang
ARCHS = arm64 armv7 armv7s
SYSROOT=/opt/theos/sdks/iPhoneOS10.1.sdk
SDKVERSION=10.2
DEBUG = 0
GO_EASY_ON_ME = 1
LDFLAGS += -Wl,-segalign,0x4000
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SiriLog
SiriLog_FILES = Tweak.xm PO2Log.mm
SiriLog_FRAMEWORKS = UIKit Foundation
SiriLog_PRIVATE_FRAMEWORKS = AssistantServices AssistantUI

SiriLog_CFLAGS += -DVERBOSE
SiriLog_LDFLAGS += -lAccessibility
SiriLog_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

sync: stage
	rsync -e "ssh -p 2222" -avz .theos/_/Library/MobileSubstrate/DynamicLibraries/* root@127.0.0.1:/Library/MobileSubstrate/DynamicLibraries/
	ssh root@127.0.0.1 -p 2222 killall SpringBoard
