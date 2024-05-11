TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE=1

THEOS_PACKAGE_SCHEME=rootless
THEOS_DEVICE_IP=192.168.102.66

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LottieBridgingExample

$(TWEAK_NAME)_FILES = Tweak.x LottieWrapper.swift
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit Lottie

include $(THEOS_MAKE_PATH)/tweak.mk
