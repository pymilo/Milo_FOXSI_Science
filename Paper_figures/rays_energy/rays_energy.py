## Generate rays and save them in a CSV file for Iridium mirrors.
## @Milo
## October 2018

import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime
from foxsisim.module import Module
from foxsisim.source import Source
from foxsisim.util import save_rays

folder = '/Users/Kamilobu/Desktop/Developer/Milo_FOXSI_Science/Paper_figures/rays_energy/F309R262/'
nrays = 1000          ## Number of rays
max_energy = 30.0       ## Maximum energy
fbr = 3.09671           ## Front blocker radius
rbr = 2.62              ## Rear blocker radius


''' Defining Input Spectrum '''
def spectrum(z):
        if (type(z) is not type([1])) and (type(z) is not type(np.array(1))):
            x = np.array([z])
        else:
            x = np.array(z)
        return np.piecewise(x, [x < 0, ((x < max_energy) & (x > 0)), (x >= max_energy)], [0, 1./max_energy, 0])

''' Creating the FOXSI telescope '''
module = Module(radii = [5.151,4.9,4.659,4.429,4.21,4.0,3.799,3.59,3.38,3.17], core_radius=(fbr,rbr))    


angle = 28.0

Sdist = -1.5e13         ## Source distance in cm
Xs = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
Ys = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
source = Source(type='point', center=[Xs, Ys, Sdist ])
source.loadSpectrum(spectrum)

''' Generating rays '''
tstart = datetime.now()
rays = source.generateRays(module.targetFront, nrays)
tgen = datetime.now()
print('rays generated, time = ' + str((tgen - tstart).seconds) + 'seconds' )

print('Pasing rays')
module.passRays(rays)

Trays = [ray for ray in rays if (ray.dead==False)] ## save only those alive rays
save_rays(Trays,filename=folder+'test_rays_Angle_=_'+str(angle)+'.csv')
print('rays saved, time = ' + str((datetime.now() - tstart).seconds) + 'seconds' )


