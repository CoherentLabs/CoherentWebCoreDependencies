LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libtest
LOCAL_CFLAGS    := -Werror
LOCAL_CFLAGS 	+= $(FEATURE_DEFINES)
LOCAL_CPPFLAGS	:= -std=c++11

LOCAL_SRC_FILES := test.cpp

LOCAL_LDLIBS    := -llog -lGLESv2
$(LOCAL_PATH)/test.cpp: \
	icu-data \
	icuuc \
	libxml2 \
#


include $(BUILD_SHARED_LIBRARY)

$(call import-module, icu4c-53_1)
$(call import-module, libxml2-2.9.1)

