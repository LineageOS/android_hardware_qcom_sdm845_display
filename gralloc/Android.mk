# Gralloc module
LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

LOCAL_MODULE                  := gralloc.$(TARGET_BOARD_PLATFORM)
LOCAL_LICENSE_KINDS           := SPDX-license-identifier-Apache-2.0 SPDX-license-identifier-BSD legacy_not_a_contribution
LOCAL_LICENSE_CONDITIONS      := by_exception_only not_allowed notice
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_RELATIVE_PATH    := hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)

LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_SHARED_LIBRARIES        := $(common_libs) libqdMetaData libsync libgrallocutils \
                                 libgralloccore \
                                 android.hardware.graphics.mapper@2.0 \
                                 android.hardware.graphics.mapper@2.1
LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdgralloc\" -Wall -Werror
LOCAL_CLANG                   := true
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := gr_device_impl.cpp
include $(BUILD_SHARED_LIBRARY)

#libgralloccore
include $(CLEAR_VARS)
LOCAL_MODULE                  := libgralloccore
LOCAL_LICENSE_KINDS           := SPDX-license-identifier-Apache-2.0 SPDX-license-identifier-BSD legacy_not_a_contribution
LOCAL_LICENSE_CONDITIONS      := by_exception_only not_allowed notice
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_SHARED_LIBRARIES        := $(common_libs) libqdMetaData libdl libgrallocutils \
                                  android.hardware.graphics.mapper@2.1
LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdgralloc\" -Wno-sign-conversion
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := gr_allocator.cpp gr_buf_mgr.cpp gr_ion_alloc.cpp
include $(BUILD_SHARED_LIBRARY)


qti_mapper_version := $(shell \
    if [ -d "$(TOP)/vendor/qcom/opensource/interfaces/display/mapper/1.0" ];\
    then echo QTI_MAPPER_1_0; fi)

qti_allocator_version := $(shell \
    if [ -d "$(TOP)/vendor/qcom/opensource/interfaces/display/allocator/1.0" ];\
    then echo QTI_ALLOCATOR_1_0; fi)


#mapper
include $(CLEAR_VARS)
LOCAL_MODULE                  := android.hardware.graphics.mapper@2.0-impl-qti-display
LOCAL_LICENSE_KINDS           := SPDX-license-identifier-Apache-2.0 SPDX-license-identifier-BSD legacy_not_a_contribution
LOCAL_LICENSE_CONDITIONS      := by_exception_only not_allowed notice
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_RELATIVE_PATH    := hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_SHARED_LIBRARIES        := $(common_libs) \
                                  libhidlbase \
                                  libqdMetaData \
                                  libgrallocutils \
                                  libgralloccore \
                                  libsync \
                                  android.hardware.graphics.mapper@2.0 \
                                  android.hardware.graphics.mapper@2.1
LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdgralloc\" -Wno-sign-conversion
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := QtiMapper.cpp
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE                  := vendor.qti.hardware.display.allocator@1.0-service
LOCAL_LICENSE_KINDS           := SPDX-license-identifier-Apache-2.0 SPDX-license-identifier-BSD legacy_not_a_contribution
LOCAL_LICENSE_CONDITIONS      := by_exception_only not_allowed notice
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_RELATIVE_PATH    := hw
LOCAL_MODULE_TAGS             := optional
LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_SHARED_LIBRARIES        := $(common_libs) \
                                 libhidlbase \
                                 libqdMetaData \
                                 libgrallocutils \
                                 libgralloccore \
                                 android.hardware.graphics.mapper@2.1 \
                                 android.hardware.graphics.allocator@2.0
LOCAL_CFLAGS                  := -DLOG_TAG=\"qdgralloc\" $(common_flags)
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SRC_FILES               := QtiAllocator.cpp service.cpp
LOCAL_INIT_RC                 := vendor.qti.hardware.display.allocator@1.0-service.rc
include $(BUILD_EXECUTABLE)
