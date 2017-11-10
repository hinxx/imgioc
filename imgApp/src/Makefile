TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

PROD_NAME = imgApp
PROD_IOC += $(PROD_NAME)

# <name>.dbd will be created from <name>Include.dbd
DBD += $(PROD_NAME).dbd

# This needs to go first!
# Make sure that duplicate DBDs are not pulled in!
include $(ADCORE)/ADApp/commonDriverMakefile

$(PROD_NAME)_DBD += aravisCameraSupport.dbd
$(PROD_NAME)_DBD += tlccsSupport.dbd
$(PROD_NAME)_DBD += tlpm100Support.dbd
$(PROD_NAME)_DBD += drvAsynUSBTMC.dbd
$(PROD_NAME)_DBD += stream.dbd
$(PROD_NAME)_DBD += lairdtechPR59Support.dbd
$(PROD_NAME)_DBD += drvAsynSerialPort.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
PROD_SRCS += $(PROD_NAME)_registerRecordDeviceDriver.cpp $(PROD_NAME)Main.cpp

# Add locally compiled object code
PROD_LIBS += aravisCamera
PROD_LIBS += tlccs
PROD_LIBS += asyn
PROD_LIBS += stream
PROD_LIBS += lairdtechPR59

PROD_SYS_LIBS += aravis-0.4
PROD_SYS_LIBS += giomm-2.4
PROD_SYS_LIBS += usb-1.0

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

