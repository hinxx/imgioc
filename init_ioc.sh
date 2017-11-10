#!/bin/bash

source $HOME/bin/ng3esetup.sh
which caget >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "caget not found in PATH!"
	exit 1
fi


#
# CCS175 spectrometer initialization
#

caput    CCS1:det1:TlWavelengthDataTarget 0
caput    CCS1:det1:TlWavelengthDataGet 1
caget    CCS1:det1:TlWavelengthMinimum CCS1:det1:TlWavelengthMaximum
caput    CCS1:det1:TlAmplitudeDataMode 0
caput    CCS1:det1:TlAmplitudeDataTarget 2
caput    CCS1:det1:TlAmplitudeDataGet 1
caput    CCS1:trace1:EnableCallbacks 1

caput -S CCS1:HDF1:FilePath "/tmp"
caput -S CCS1:HDF1:FileName "spectra1"
caput -S CCS1:HDF1:FileTemplate "%s%s_%3.3d.h5"
caput    CCS1:HDF1:AutoIncrement 1
caput    CCS1:HDF1:AutoSave 1
caput -S CCS1:HDF1:NDAttributesFile "CCSxxxAttributes.xml"

caput -S CCS1:HDF2:FilePath "/tmp"
caput -S CCS1:HDF2:FileName "spectra2"
caput -S CCS1:HDF2:FileTemplate "%s%s_%3.3d.h5"
caput    CCS1:HDF2:AutoIncrement 1
caput    CCS1:HDF2:AutoSave 1
caput -S CCS1:HDF2:NDAttributesFile "CCSxxxAttributes.xml"

caput -S CCS1:HDF3:FilePath "/tmp"
caput -S CCS1:HDF3:FileName "spectra3"
caput -S CCS1:HDF3:FileTemplate "%s%s_%3.3d.h5"
caput    CCS1:HDF3:AutoIncrement 1
caput    CCS1:HDF3:AutoSave 1
caput -S CCS1:HDF3:NDAttributesFile "CCSxxxAttributes.xml"

#
# Camera initialization
#

caput    CAM1:Stats1:EnableCallbacks 1
caput    CAM1:image1:EnableCallbacks 1

caput -S CAM1:HDF1:FilePath "/tmp"
caput -S CAM1:HDF1:FileName "image1"
caput -S CAM1:HDF1:FileTemplate "%s%s_%3.3d.h5"
caput    CAM1:HDF1:AutoIncrement 1
caput    CAM1:HDF1:AutoSave 1
caput -S CAM1:HDF1:NDAttributesFile "mantaG125BAttributes.xml"

caput -S CAM1:HDF2:FilePath "/tmp"
caput -S CAM1:HDF2:FileName "image2"
caput -S CAM1:HDF2:FileTemplate "%s%s_%3.3d.h5"
caput    CAM1:HDF2:AutoIncrement 1
caput    CAM1:HDF2:AutoSave 1
caput -S CAM1:HDF2:NDAttributesFile "mantaG125BAttributes.xml"

caput -S CAM1:HDF3:FilePath "/tmp"
caput -S CAM1:HDF3:FileName "image3"
caput -S CAM1:HDF3:FileTemplate "%s%s_%3.3d.h5"
caput    CAM1:HDF3:AutoIncrement 1
caput    CAM1:HDF3:AutoSave 1
caput -S CAM1:HDF3:NDAttributesFile "mantaG125BAttributes.xml"


#
# Heater initialization
#

# Temperature sensor 1 settings
# We have PT1000 sensor, only coefficients A, B and resistance high are used
# Values from LT_Interface tool for 'PT1000'
caput LT59:Temp1Mode "PT"
caput LT59:Temp1ResHigh 1000
caput LT59:Temp1ResMed 0
caput LT59:Temp1ResLow 0
caput LT59:Temp1CoeffA 3.90799996e-03
caput LT59:Temp1CoeffB -5.77499975e-07
caput LT59:Temp1CoeffC 0

# Temperature sensor 4 settings
# This is internal sensor, NTC type
# Values from LT_Interface tool for 'RH16-10K'
caput LT59:Temp4Mode "NTC"
caput LT59:Temp4ResHigh 2965.1389
caput LT59:Temp4ResMed 28836.7891
caput LT59:Temp4ResLow 78219.9922
caput LT59:Temp4CoeffA 6.84353872e-04
caput LT59:Temp4CoeffB 2.89854885e-04
caput LT59:Temp4CoeffC 4.39709385e-13

# Regulator settings
caput LT59:Mode "P"
caput LT59:ModeFlags "None"
caput LT59:FilterA "Off"
caput LT59:FilterB "Off"
caput LT59:StartStop "Stop"

# Get initial values
caput LT59:Retrieve 1
