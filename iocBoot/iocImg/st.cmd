< envPaths
errlogInit(20000)

dbLoadDatabase("$(TOP)/dbd/imgApp.dbd")
imgApp_registerRecordDeviceDriver(pdbbase) 

# The search path for ADCore database files
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(ADCORE)/db")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "30000000")

################################################################################
## Allied Vision Manta G125B
################################################################################

epicsEnvSet("PREFIX", "CAM1:")
epicsEnvSet("PORT",   "CAM1")
epicsEnvSet("QSIZE",  "20")
epicsEnvSet("XSIZE",  "1292")
epicsEnvSet("YSIZE",  "964")
epicsEnvSet("NCHANS", "2048")
epicsEnvSet("CBUFFS", "500")

aravisCameraConfig("$(PORT)", "Allied Vision Technologies-50-0503374607")

# asynSetTraceMask("$(PORT)", 0, 0x21)
dbLoadRecords("$(ADARAVIS)/db/aravisCamera.template",   "P=$(PREFIX),R=det1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(ADARAVIS)/db/AVT_Manta_G125B.template","P=$(PREFIX),R=det1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")

# Create a standard arrays plugin
# Allow for images up to 1292x964x3 for RGB
NDStdArraysConfigure("$(PORT)Image1", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=$(PORT)Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=3736464")
NDStdArraysConfigure("$(PORT)Image2", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image2:,PORT=$(PORT)Image2,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=3736464")
NDStdArraysConfigure("$(PORT)Image3", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image3:,PORT=$(PORT)Image3,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=3736464")

# Load all other plugins using commonPlugins.cmd
< $(TOP)/iocBoot/$(IOC)/commonPlugins.cmd

#set_requestfile_path("$(ADARAVIS)/aravisGigEApp/Db")

#asynSetTraceMask("$(PORT)",0,255)
#asynSetTraceMask("$(PORT)",0,3)

################################################################################
## Thorlabs CCS100
################################################################################

# Resource string: USB::VID::PID::SERIAL::RAW
epicsEnvSet("RSCSTR", "USB::0x1313::0x8081::M00407489::RAW")

epicsEnvSet("PREFIX", "CCS1:")
epicsEnvSet("PORT",   "CCS1")
epicsEnvSet("QSIZE",  "20")
epicsEnvSet("XSIZE",  "3648")
epicsEnvSet("YSIZE",  "1")
epicsEnvSet("NCHANS", "2048")
epicsEnvSet("CBUFFS", "500")

# Create a Thorlabs CCSxxx driver
# tlCCSConfig(const char *portName, int maxBuffers, size_t maxMemory, 
#             const char *resourceName, int priority, int stackSize)
tlCCSConfig("$(PORT)", 0, 0, "$(RSCSTR)", 0, 0)
dbLoadRecords("$(ADTLCCS)/tlccsApp/Db/tlccs.template", "P=$(PREFIX),R=det1:,PORT=$(PORT),ADDR=0,TIMEOUT=1,NELEMENTS=$(XSIZE)")

# Create standard arrays plugin for a trace
NDStdArraysConfigure("$(PORT)Trace1", $(QSIZE), 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/ADApp/Db/NDStdArrays.template", "P=$(PREFIX),R=trace1:,PORT=$(PORT)Trace1,ADDR=0,TIMEOUT=1,TYPE=Float64,FTVL=DOUBLE,NELEMENTS=4000,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")
NDStdArraysConfigure("$(PORT)Trace2", $(QSIZE), 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/ADApp/Db/NDStdArrays.template", "P=$(PREFIX),R=trace2:,PORT=$(PORT)Trace2,ADDR=0,TIMEOUT=1,TYPE=Float64,FTVL=DOUBLE,NELEMENTS=4000,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")
NDStdArraysConfigure("$(PORT)Trace3", $(QSIZE), 0, "$(PORT)", 0, 0)
dbLoadRecords("$(ADCORE)/ADApp/Db/NDStdArrays.template", "P=$(PREFIX),R=trace3:,PORT=$(PORT)Trace3,ADDR=0,TIMEOUT=1,TYPE=Float64,FTVL=DOUBLE,NELEMENTS=4000,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")

## Load all other plugins using commonPlugins.cmd
< $(TOP)/iocBoot/$(IOC)/commonPlugins.cmd

#set_requestfile_path("$(ADTLCCS)/tlccsApp/Db")

#asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",0,255)

################################################################################
## Thorlabs PM100USB
################################################################################

epicsEnvSet("PREFIX", "PM100:")
epicsEnvSet("PORT",   "PM100")

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TLPM100)/db")

#var streamDebug 1

# usbtmcConfigure(port, vendorNum, productNum, serialNumberStr, priority, flags)
usbtmcConfigure("$(PORT)")
asynSetTraceIOMask("$(PORT)",0,0xff)
#asynSetTraceMask("$(PORT)",0,0xff)

# Load record instances
dbLoadRecords("$(TLPM100)/db/tlPM100.template","P=$(PREFIX),R=,PORT=$(PORT)")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn,PORT=$(PORT),ADDR=0,OMAX=100,IMAX=100")

################################################################################
## Lairdtech PR59
################################################################################

epicsEnvSet("DEVICE",      "/dev/ttyUSB0")
epicsEnvSet("SERIAL_PORT", "LT59_SERIAL")
epicsEnvSet("PREFIX",      "LT59:")
epicsEnvSet("PORT",        "LT59")

# drvAsynSerialPortConfigure(port, ttyName, priority, noAutoConnect, noProcessEosIn)
drvAsynSerialPortConfigure("$(SERIAL_PORT)", "$(DEVICE)", 0, 0, 0)
asynSetOption("$(SERIAL_PORT)", 0, "baud",   "115200")
asynSetOption("$(SERIAL_PORT)", 0, "bits",   "8")
asynSetOption("$(SERIAL_PORT)", 0, "parity", "none")
asynSetOption("$(SERIAL_PORT)", 0, "stop",   "1")
asynSetOption("$(SERIAL_PORT)", 0, "clocal", "Y")
asynSetOption("$(SERIAL_PORT)", 0, "crtscts","N")

asynOctetSetInputEos("$(SERIAL_PORT)", 0, "\r\n")
asynOctetSetOutputEos("$(SERIAL_PORT)", 0, "\r")

#asynSetTraceIOMask("$(SERIAL_PORT)",0,0xff)
#asynSetTraceMask("$(SERIAL_PORT)",0,0xff)

# LTPR59Configure(const char *portName, const char *serialPort);
LTPR59Configure($(PORT), $(SERIAL_PORT))
#asynSetTraceIOMask("$(PORT)",0,0xff)
#asynSetTraceMask("$(PORT)",0,0xff)

# Load record instances
dbLoadRecords("$(LAIRDTECHPR59)/db/lairdtechPR59_main.template", "P=$(PREFIX),R=,PORT=$(PORT),SERIAL_PORT=$(SERIAL_PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(LAIRDTECHPR59)/db/lairdtechPR59_pid.template",  "P=$(PREFIX),R=,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(LAIRDTECHPR59)/db/lairdtechPR59_temp.template", "P=$(PREFIX),R=,T=1,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(LAIRDTECHPR59)/db/lairdtechPR59_temp.template", "P=$(PREFIX),R=,T=4,PORT=$(PORT),ADDR=0,TIMEOUT=1")
# TODO: Add support for other temperature sensors
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn,PORT=$(PORT),ADDR=0,OMAX=100,IMAX=100")

################################################################################

# For Autosave, before iocInit is called
#set_requestfile_path(".")
#set_savefile_path("./autosave")
#set_pass0_restoreFile("auto_settings.sav")
#set_pass1_restoreFile("auto_settings.sav")


# optional custom PVs
#dbLoadRecords("$(TOP)/db/img.db", "P=IMG:,R=")

iocInit()

# save things every thirty seconds
#create_monitor_set("cam_auto_settings.req", 30,"P=$(PREFIX)")
#create_monitor_set("ccs_auto_settings.req", 30,"P=$(PREFIX)")
