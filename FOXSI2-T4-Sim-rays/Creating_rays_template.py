###########    TEMPLATE    #######################
## Code to be copied in Juan Carloses machine "amaterasu"
## to create a CSV file containing rays.
## @Milo
## Feb 2019

import numpy as np
import matplotlib.pyplot as plt
from foxsisim.source import Source
from foxsisim.module import Module
from foxsisim.util import save_rays
from datetime import datetime
tstart = datetime.now()

nrays = 100   ## Number of rays
fbr = 2.855   ## X0    - 10Shell
rbr = 2.6     ## X0    - 10Shell
#fbr = 2.86   ## X1456 - 7Shell
#rbr = 2.59   ## X1456 - 7Shell

source_distance = -1.496e+13      ## cm
offaxis_angle_arcminX = 18.74   ## AR1
offaxis_angle_arcminY = 16.84   ## AR1
#offaxis_angle_arcminX = 5.88    ## AR2
#offaxis_angle_arcminY = 11.5    ## AR2

source = Source(type='point', center=[-source_distance * np.sin(np.deg2rad(offaxis_angle_arcminX / 60.0)),
                                      -source_distance * np.sin(np.deg2rad(offaxis_angle_arcminY / 60.0)),
                                      source_distance])

''' Creating the FOXSI telescope '''

module = Module(radii = [5.151,4.9,4.659,4.429,4.21,4.0,3.799,3.59,3.38,3.17],  #10Shells
#module = Module(radii = [5.151,4.9,4.659,4.429,4.21,4.0,3.799],                #7Shells
                core_radius=(fbr,rbr))

''' Generating rays '''
rays = source.generateRays(module.targetFront, nrays)

tgen = datetime.now()
print('rays generated, time = ' + str((tgen - tstart).seconds) + 'seconds' )

print('Pasing rays')
module.passRays(rays)

save_rays(rays,filename='D0AR1.csv')

print('Time total: ' + str((datetime.now() - tgen).seconds) + ' seconds')
