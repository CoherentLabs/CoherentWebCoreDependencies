LOCAL_PATH:= $(call my-dir)

# We need to build this for both the device (as a shared library)
# and the host (as a static library for tools to use).

common_SRC_FILES := \
	png.c \
	pngerror.c \
	pngget.c \
	pngmem.c \
	pngpread.c \
	pngread.c \
	pngrio.c \
	pngrtran.c \
	pngrutil.c \
	pngset.c \
	pngtrans.c \
	pngwio.c \
	pngwrite.c \
	pngwtran.c \
	pngwutil.c \

ifeq ($(ARCH_ARM_HAVE_NEON),true)
my_cflags_arm := -DPNG_ARM_NEON_OPT=2 -DPNG_ARM_NEON_CHECK_SUPPORTED
endif

my_cflags_arm64 := -DPNG_ARM_NEON_OPT=2 -DPNG_ARM_NEON_CHECK_SUPPORTED

# BUG: http://llvm.org/PR19472 - SLP vectorization (on ARM at least) crashes
# when we can't lower a vectorized bswap.
my_cflags_arm += -fno-slp-vectorize

my_src_files_arm := \
			arm/arm_init.c \
			arm/filter_neon.S \
			arm/filter_neon_intrinsics.c


common_CFLAGS := -std=gnu89 #-fvisibility=hidden ## -fomit-frame-pointer

common_C_INCLUDES +=

common_COPY_HEADERS_TO := libpng
common_COPY_HEADERS := png.h pngconf.h pngusr.h


# For the device (static)
# =====================================================

include $(CLEAR_VARS)
LOCAL_CLANG := true
LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS) -ftrapv
LOCAL_CFLAGS_arm := $(my_cflags_arm)
LOCAL_ASFLAGS += $(common_ASFLAGS)
LOCAL_SRC_FILES_arm := $(my_src_files_arm)
LOCAL_CFLAGS_arm64 := $(my_cflags_arm64)
LOCAL_SRC_FILES_arm64 := $(my_src_files_arm)

LOCAL_C_INCLUDES += $(common_C_INCLUDES) \
	external/zlib
LOCAL_SHARED_LIBRARIES := \
	libz

LOCAL_MODULE:= libpng

include $(BUILD_STATIC_LIBRARY)

