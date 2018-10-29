import numpy as np
from foxsisim.source import Source
from foxsisim.module import Module
from foxsisim.util import load_rays, save_rays
from foxsisim.detector import Detector

n = 1000000             ## number of rays
fbr = 3.09671
rbr = 2.62
Sdist = -1.5e13        ## cm
#offaxisAngle = 0.0    ## arcmin
offaxisAngles = np.arange(4.,33.,4.)     ## arcmin


for angle in offaxisAngles:
    #Create Source :
    Xs = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
    Ys = -Sdist * np.sin(np.deg2rad(np.sqrt(2.) * angle / 120.0))
    source = Source(type='point',center=[Xs, Ys, Sdist ])
    print('Off-axis Angle: %f' % angle)
    module = Module(radii = [5.151,4.9,4.659,4.429,4.21,4.0,3.799,3.59,3.38,3.17], core_radius=(fbr,rbr))
    rays = source.generateRays(module.targetFront,n)
    module.passRays(rays)
    #Rrays = [ray for ray in rays if (ray.tag != 'Source')] #kills the passthrough rays
    save_rays(rays,filename='/Users/Kamilobu/Desktop/Developer/Milo_FOXSI_Science/Paper_figures/rays/F309R262/rays_Angle_=_'+str(angle)+'.csv')


