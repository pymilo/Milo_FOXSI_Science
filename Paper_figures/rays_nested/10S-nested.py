import numpy as np
from datetime import datetime
from foxsisim.source import Source
from foxsisim.module import Module
from foxsisim.util import load_rays, save_rays
from foxsisim.detector import Detector

n = 1000000            ## number of rays
fbr = 3.09671
rbr = 2.62
Sdist = -1.5e13        ## cm

angle = 30.0    ## arcmin
factor = np.arange(1.,3.2,.2)   

''' Generating rays '''
tstart = datetime.now()

for f in factor:
    #Create Source :
    Xs = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
    Ys = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
    source = Source(type='point',center=[Xs, Ys, Sdist ])
    print('Factor: %f' % round(f,2))
    module = Module(radii = f * np.array([5.151,4.9,4.659,4.429,4.21,4.0,3.799,3.59,3.38,3.17]), core_radius=(fbr,rbr))
    rays = source.generateRays(module.targetFront,n)
    module.passRays(rays)
    #Rrays = [ray for ray in rays if (ray.tag != 'Source')] #kills the passthrough rays
    Trays = [ray for ray in rays if (ray.dead==False)] ## save only those alive rays
    save_rays(Trays,filename='/Users/Kamilobu/Desktop/Developer/Milo_FOXSI_Science/Paper_figures/rays_nested/F309R262/rays_Factor_=_'+str(round(f,2))+'.csv')


print('rays saved, time = ' + str((datetime.now() - tstart).seconds) + 'seconds' )
