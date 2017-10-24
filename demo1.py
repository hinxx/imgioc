from epics import caget, caput

# a random PV ..
m1 = caget('CCS1:det1:NumImagesCounter_RBV')
print(m1)

m2 = caget('CCS1:det1:AcquireTime_RBV')
print(m2)
caput('CCS1:det1:AcquireTime', 0.013)
m3 = caget('CCS1:det1:AcquireTime_RBV')
print(m3)

from epics import PV
pv1_rbv = PV('CCS1:det1:AcquireTime_RBV')
pv1_sp = PV('CCS1:det1:AcquireTime')
print(pv1_rbv.get())

pv1_sp.put(0.033)

import time
time.sleep(1)

print(pv1_rbv.get())

