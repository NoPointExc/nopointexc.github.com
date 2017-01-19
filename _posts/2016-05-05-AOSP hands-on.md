---
layout: post
title: AOSP Basic Configs
category: Categories
---

### ADB multi-devices  
adb -s [device-name] install Hello.apk

### compile app module under packages/
``mm`` may not work under local dir, try make [target-module] in root dir

### ADB Shell, switch/create user

Create new user: `pm create-user User_Name`  
To switch between users: `am switch-user User_ID`  
To get the list of all the users: `pm list users` or `pm list-users`  
To delete a user: `pm remove-user User_ID`  

### ADB shell, swithc root/unroot  
    ~$ adb shell id
    uid=2000(shell) gid=2000(shell)
    
    ~$ adb root
    restarting adbd as root
    
    ~$ adb shell id
    uid=0(root) gid=0(root)
    
    ~$ adb shell 'setprop service.adb.root 0; setprop ctl.restart adbd'
    
    ~$ adb shell id
    uid=2000(shell) gid=2000(shell)  

### device.mk  
FUNCTION: definition Makefile that declares the files and modules needed for this device. 
WHERE: `device/<vendor, moto.eg>/<platform, sofia.eg>/<device, 3gr.e.g>/device.mk`  
TAGS:  
- `PRODUCT_PACKAGES` lists the APKs and modules to install. 
- `PRODUCT_NAME` end-user-visible name for the overall product, appers in the Setting>About screen.  

For more info about TAGs: https://source.android.com/source/add-device.html#prod-def

### foo_3gr.mk <device defination mk>  
FUNCTION: a product definition Makefile to create a specific product based on the device.  The following Makefile is taken from `device/moto/shamu/aosp_shamu.mk` as an example. Notice the product is inheriting from the `device/moto/shamu/device.mk` and `vendor/moto/shamu/device-vendor.mk` files via the Makefile while also declaring the product-specific information such as name, brand, and model.
WHERE: same dir with device.mk

    # Inherit from the common Open Source product configuration
    $(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
    
    PRODUCT_NAME := aosp_shamu
    PRODUCT_DEVICE := shamu
    PRODUCT_BRAND := Android
    PRODUCT_MODEL := AOSP on Shamu
    PRODUCT_MANUFACTURER := motorola
    PRODUCT_RESTRICT_VENDOR_FILES := true
    
    $(call inherit-product, device/moto/shamu/device.mk)
    $(call inherit-product-if-exists, vendor/moto/shamu/device-vendor.mk)
    
    PRODUCT_NAME := aosp_shamu
    
    PRODUCT_PACKAGES += \
    Launcher3

### AndroidProducts.mk  
FUNCTION:  points to the product's Makefiles, a list of products makefiles to expose to the build system. `LOCAL_DIR` will already be set to be the directory containing this file.  
This file may not rely on the value of any variable other than LOCAL_DIR; do not use any conditionals, and do not look up the value of any variable that isn't set in this file or in a file that it includes.
WHERE: `device/<vendor>/<platform>/`  , parent dir of device.mk

### BoardConfig.mk  
FUNCTION: bord-specific configurations.  
WHERE: same dir with device.mk  

### vendorsetup.sh  
FUNCTION: add your product (a lunch combo) the lunch menun.  
WHERE: `device/<vendor>/<platform>/`  , parent dir of device.mk  
    
    add_lunch_combo r1_edw-eng
    add_lunch_combo r2_sjy-eng




See also: https://source.android.com/source/64-bit-builds.html