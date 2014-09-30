LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

XML2_ROOT = $(abspath $(LOCAL_PATH))

# We need to build this for both the device (as a shared library)
# and the host (as a static library for tools to use).

common_SRC_FILES := \
    $(XML2_ROOT)/buf.c \
    $(XML2_ROOT)/SAX.c \
    $(XML2_ROOT)/entities.c \
    $(XML2_ROOT)/encoding.c \
    $(XML2_ROOT)/error.c \
    $(XML2_ROOT)/parserInternals.c \
    $(XML2_ROOT)/parser.c \
    $(XML2_ROOT)/tree.c \
    $(XML2_ROOT)/hash.c \
    $(XML2_ROOT)/list.c \
    $(XML2_ROOT)/xmlIO.c \
    $(XML2_ROOT)/xmlmemory.c \
    $(XML2_ROOT)/uri.c \
    $(XML2_ROOT)/valid.c \
    $(XML2_ROOT)/xlink.c \
    $(XML2_ROOT)/HTMLparser.c \
    $(XML2_ROOT)/HTMLtree.c \
    $(XML2_ROOT)/debugXML.c \
    $(XML2_ROOT)/xpath.c \
    $(XML2_ROOT)/xpointer.c \
    $(XML2_ROOT)/xinclude.c \
    $(XML2_ROOT)/nanohttp.c \
    $(XML2_ROOT)/nanoftp.c \
    $(XML2_ROOT)/DOCBparser.c \
    $(XML2_ROOT)/catalog.c \
    $(XML2_ROOT)/globals.c \
    $(XML2_ROOT)/threads.c \
    $(XML2_ROOT)/c14n.c \
    $(XML2_ROOT)/xmlstring.c \
    $(XML2_ROOT)/xmlregexp.c \
    $(XML2_ROOT)/xmlschemas.c \
    $(XML2_ROOT)/xmlschemastypes.c \
    $(XML2_ROOT)/xmlunicode.c \
    $(XML2_ROOT)/xmlreader.c \
    $(XML2_ROOT)/relaxng.c \
    $(XML2_ROOT)/dict.c \
    $(XML2_ROOT)/SAX2.c \
    $(XML2_ROOT)/legacy.c \
    $(XML2_ROOT)/chvalid.c \
    $(XML2_ROOT)/pattern.c \
    $(XML2_ROOT)/xmlsave.c \
    $(XML2_ROOT)/xmlmodule.c \
    $(XML2_ROOT)/xmlwriter.c \
    $(XML2_ROOT)/schematron.c \
#

DEPS_ROOT := $(XML2_ROOT)/..
ICU_ROOT := $(DEPS_ROOT)/icu4c-53_1

common_C_INCLUDES += \
	$(XML2_ROOT) \
	$(XML2_ROOT)/include \
	$(ICU_ROOT)/source/common \
	$(ICU_ROOT)/source/io \
#

# Turn off warnings to prevent log message spam
# These warnings are not disabled because they are not supported by gcc 4.2.1
# which is used by darwin.
# -Wno-enum-compare
# -Wno-array-bounds

DISABLED_WARNING_FLAGS := \
	-Wno-format \
	-Wno-pointer-sign \
	-Wno-sign-compare

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)
LOCAL_SHARED_LIBRARIES += $(common_SHARED_LIBRARIES)
LOCAL_CFLAGS += -fvisibility=hidden
LOCAL_CFLAGS += $(DISABLED_WARNING_FLAGS)

LOCAL_MODULE:= libxml2

include $(BUILD_STATIC_LIBRARY)
