import numpy as np
from foxsisim.source import Source
from foxsisim.module import Module
Sdist = -10000          ## cm
offaxisAngle = 10.0     ## arcmin
source = Source(type='point',center=[0, -Sdist * np.sin(np.deg2rad(offaxisAngle / 60.0)), Sdist ])
module = Module(radii = [5.151,4.9,4.659,4.429,4.21,4.0,3.799,3.59,3.38,3.17],core_radius=2.805)
n = 3000000
rays = source.generateRays(module.targetFront,n)
module.passRays(rays)
Rrays = [ray for ray in rays if (ray.tag != 'Source')] #kills the passthrough rays
from foxsisim.util import save_rays
save_rays(Rrays,filename='rays_on_module_3M.csv')
print(len(Rrays),' rays saved')
print('Done!')


