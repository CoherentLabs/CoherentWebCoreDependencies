LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libtest
LOCAL_CFLAGS    := -Werror
LOCAL_CFLAGS 	+= $(FEATURE_DEFINES)
LOCAL_CPPFLAGS	:= -std=c++11

LOCAL_SRC_FILES := test.cpp

LOCAL_LDLIBS    := -llog -lGLESv2
$(LOCAL_PATH)/test.cpp: \
	icuuc \
	icui18n \
	png \
	jpeg \
	xml2 \
	curl \
#


include $(BUILD_SHARED_LIBRARY)

$(call import-module, icu4c-53_1)
$(call import-module, libxml2-2.9.1)
$(call import-module, libjpeg-turbo)
$(call import-module, libpng-1.6.10)
$(call import-module, curl-7.36.0)

