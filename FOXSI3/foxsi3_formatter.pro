; Milo BC 
; Creating Level 0 using formatter data
filename = 'data_2018/data_180907_111001.dat'
data_lvl0_D0 = formatter_data_to_level0( filename, det=0 )
data_lvl0_D1 = formatter_data_to_level0( filename, det=1 )
data_lvl0_D2 = formatter_data_to_level0( filename, det=2 )
data_lvl0_D3 = formatter_data_to_level0( filename, det=3 )
data_lvl0_D4 = formatter_data_to_level0( filename, det=4 )
data_lvl0_D5 = formatter_data_to_level0( filename, det=5 )
data_lvl0_D6 = formatter_data_to_level0( filename, det=6 )
save, data_lvl0_D0, data_lvl0_D1, data_lvl0_D2, data_lvl0_D3, $
		data_lvl0_D4, data_lvl0_D5, data_lvl0_d6, $
		file = 'data_2018/formatter_data.sav'
; Create Level 1 data
filename = 'data_2018/formatter_data.sav'
data_lvl1_D0 = foxsi_level0_to_level1( filename, det=0, ground=1 )
data_lvl1_D1 = foxsi_level0_to_level1( filename, det=1, ground=1 )
data_lvl1_D2 = foxsi_level0_to_level1( filename, det=2, ground=1 )
data_lvl1_D3 = foxsi_level0_to_level1( filename, det=3, ground=1, /cdte )
data_lvl1_D4 = foxsi_level0_to_level1( filename, det=4, ground=1 )
data_lvl1_D5 = foxsi_level0_to_level1( filename, det=5, ground=1, /cdte )
data_lvl1_D6 = foxsi_level0_to_level1( filename, det=6, ground=1 )
save, data_lvl1_D0, data_lvl1_D1, data_lvl1_D2, data_lvl1_D3, data_lvl1_D4, $
data_lvl1_D5, data_lvl1_d6, $
file = 'data_2018/foxsi_level1_data.sav'
; Create Level 2 data
file0 = 'data_2018/formatter_data.sav'
file1 = 'data_2018/foxsi_level1_data.sav'
; Det1 was PhoEniX, Det3 and Det5 were the CdTe. All three set to det108 
cal0 = 'foxsi-science/calibration_data/peaks_det105.sav'
cal1 = 'foxsi-science/calibration_data/peaks_det108.sav'
cal2 = 'foxsi-science/calibration_data/peaks_det106.sav'
cal3 = 'foxsi-science/calibration_data/peaks_fe_3am_cdte_fec7_ht70_lt10.sav'
cal4 = 'foxsi-science/calibration_data/peaks_det102.sav'
cal5 = 'foxsi-science/calibration_data/peaks_fe_3am_cdte_fec9_Al-side.sav'
cal6 = 'foxsi-science/calibration_data/peaks_det101.sav'
data_lvl2_D0 = foxsi_level1_to_level2(file0, file1, det=0, calib=cal0, ground=1 )
data_lvl2_D1 = foxsi_level1_to_level2(file0, file1, det=1, calib=cal1, ground=1 )
data_lvl2_D2 = foxsi_level1_to_level2(file0, file1, det=2, calib=cal2, ground=1 )
data_lvl2_D3 = foxsi_level1_to_level2(file0, file1, det=3, calib=cal3, ground=1 )
data_lvl2_D4 = foxsi_level1_to_level2(file0, file1, det=4, calib=cal4, ground=1 )
data_lvl2_D5 = foxsi_level1_to_level2(file0, file1, det=5, calib=cal5, ground=1 )
data_lvl2_D6 = foxsi_level1_to_level2(file0, file1, det=6, calib=cal6, ground=1 )
save, data_lvl2_D0, data_lvl2_D1, data_lvl2_D2, data_lvl2_D3, $
data_lvl2_D4, data_lvl2_D5, data_lvl2_d6, $
file = 'data_2018/foxsi_level2_data.sav'
;
; ******************************************
; Plotting
; ******************************************
;.reset
restore, 'data_2018/foxsi_level2_data.sav'
lvl2 = data_lvl2_d2
; define time for imaging
;-----------------------------
framecounter = data_lvl2_d2.frame_counter - data_lvl2_d2[0].frame_counter
time_elp = 2.*framecounter /60. /1000. ; in minutes
time = time_elp + 1.1748650 ; in minutes
dt1 = 120.
dt2 = 30.
dt3 = 150.
dt4 = 60.
t1beg = (110.+4.)/60.                 ; in minutes
t1end = (110.+dt1-2.)/60.             ; in minutes
t2beg = (110.+dt1+4.)/60.             ; in minutes
t2end = (110.+dt1+dt2-2.)/60.         ; in minutes
t3beg = (110.+dt1+dt2+4.)/60.         ; in minutes
t3end = (110.+dt1+dt2+dt3-2.)/60.     ; in minutes
t4beg = (110.+dt1+dt2+dt3+4.)/60.     ; in minutes
t4end = (110.+dt1+dt2+dt3+dt4-2.)/60. ; in minutes
tr1 = where(time ge t1beg AND time le t1end)
tr2 = where(time ge t2beg AND time le t2end)
tr3 = where(time ge t3beg AND time le t3end)
tr4 = where(time ge t4beg AND time le t4end)
; ******* Target-1 (AR) ****************
;T1D0
foxsi3_lvl2_ground_image, data_lvl2_d0, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md0 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(0,2), fov=2*20)
map2fits,md0,'FOXSI3_T1D0.fits'
;T1D2
foxsi3_lvl2_ground_image, data_lvl2_d2, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md2 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(2,2), fov=2*20)
map2fits,md2,'FOXSI3_T1D2.fits'
;T1D3
foxsi3_lvl2_ground_image, data_lvl2_d3, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md3 = make_map(image,dx=6.1879, dy=6.1879, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(3,2), fov=2*20)
map2fits,md3,'FOXSI3_T1D3.fits'
;T1D4
foxsi3_lvl2_ground_image, data_lvl2_d4, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md4 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(4,2), fov=2*20)
map2fits,md4,'FOXSI3_T1D4.fits'
;T1D5
foxsi3_lvl2_ground_image, data_lvl2_d5, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md5 = make_map(image,dx=6.1879, dy=6.1879, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(5,2), fov=2*20)
map2fits,md5,'FOXSI3_T1D5.fits'
;T1D6
foxsi3_lvl2_ground_image, data_lvl2_d6, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md6 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:22:50.000'), id='Det'+strtrim(6,2), fov=2*20)
map2fits,md6,'FOXSI3_T1D6.fits' 
; ******* Target-2 (NP) ****************
;T2D0
foxsi3_lvl2_ground_image, data_lvl2_d0, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md0 = make_map(image,dx=7.7349, dy=7.7349, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(0,2), fov=2*20)
map2fits,md0,'FOXSI3_T2D0.fits'
;T2D2
foxsi3_lvl2_ground_image, data_lvl2_d2, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md2 = make_map(image,dx=7.7349, dy=7.7349, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(2,2), fov=2*20)
map2fits,md2,'FOXSI3_T2D2.fits'
;T2D3
foxsi3_lvl2_ground_image, data_lvl2_d3, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md3 = make_map(image,dx=6.1879, dy=6.1879, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(3,2), fov=2*20)
map2fits,md3,'FOXSI3_T2D3.fits'
;T2D4
foxsi3_lvl2_ground_image, data_lvl2_d4, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md4 = make_map(image,dx=7.7349, dy=7.7349, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(4,2), fov=2*20)
map2fits,md4,'FOXSI3_T2D4.fits'
;T2D5
foxsi3_lvl2_ground_image, data_lvl2_d5, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md5 = make_map(image,dx=6.1879, dy=6.1879, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(5,2), fov=2*20)
map2fits,md5,'FOXSI3_T2D5.fits'
;T2D6
foxsi3_lvl2_ground_image, data_lvl2_d6, minmax(tr2), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md6 = make_map(image,dx=7.7349, dy=7.7349, xcen=0.0, ycen=650.0,time=anytim('7-Sep-2018 19:24:50.000'), id='Det'+strtrim(6,2), fov=2*20)
map2fits,md6,'FOXSI3_T2D6.fits'
; ******* Target-3 (QS) ****************
;T3D0
foxsi3_lvl2_ground_image, data_lvl2_d0, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md0 = make_map(image,dx=7.7349, dy=7.7349, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(0,2), fov=2*20)
map2fits,md0,'FOXSI3_T3D0.fits'
;T3D2
foxsi3_lvl2_ground_image, data_lvl2_d2, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md2 = make_map(image,dx=7.7349, dy=7.7349, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(2,2), fov=2*20)
map2fits,md2,'FOXSI3_T3D2.fits'
;T3D3
foxsi3_lvl2_ground_image, data_lvl2_d3, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md3 = make_map(image,dx=6.1879, dy=6.1879, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(3,2), fov=2*20)
map2fits,md3,'FOXSI3_T3D3.fits'
;T3D4
;foxsi3_lvl2_ground_image, data_lvl2_d4, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
;md4 = make_map(image,dx=7.7349, dy=7.7349, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(4,2), fov=2*20)
;map2fits,md4,'FOXSI3_T3D4.fits'
;T3D5
foxsi3_lvl2_ground_image, data_lvl2_d5, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md5 = make_map(image,dx=6.1879, dy=6.1879, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(5,2), fov=2*20)
map2fits,md5,'FOXSI3_T3D5.fits'
;T3D6
foxsi3_lvl2_ground_image, data_lvl2_d6, minmax(tr3), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md6 = make_map(image,dx=7.7349, dy=7.7349, xcen=-650.0, ycen=40.0,time=anytim('7-Sep-2018 19:25:20.000'), id='Det'+strtrim(6,2), fov=2*20)
map2fits,md6,'FOXSI3_T3D6.fits'
; ******* Target-4 (AR) ****************
;T4D0
foxsi3_lvl2_ground_image, data_lvl2_d0, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md0 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(0,2), fov=2*20)
map2fits,md0,'FOXSI3_T4D0.fits'
;T4D2
foxsi3_lvl2_ground_image, data_lvl2_d2, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
md2 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(2,2), fov=2*20)
map2fits,md2,'FOXSI3_T4D2.fits'
;T3D3
foxsi3_lvl2_ground_image, data_lvl2_d3, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md3 = make_map(image,dx=6.1879, dy=6.1879, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(3,2), fov=2*20)
map2fits,md3,'FOXSI3_T4D3.fits'
;T4D4
;foxsi3_lvl2_ground_image, data_lvl2_d4, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
;md4 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(4,2), fov=2*20)
;map2fits,md4,'FOXSI3_T4D4.fits'
;T3D5
foxsi3_lvl2_ground_image, data_lvl2_d5, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1,cdte=1
md5 = make_map(image,dx=6.1879, dy=6.1879, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(5,2), fov=2*20)
map2fits,md5,'FOXSI3_T4D5.fits'
;T4D6
;foxsi3_lvl2_ground_image, data_lvl2_d6, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2',physical=1
;md6 = make_map(image,dx=7.7349, dy=7.7349, xcen=430.0, ycen=40.0,time=anytim('7-Sep-2018 19:27:50.000'), id='Det'+strtrim(6,2), fov=2*20)
;map2fits,md6,'FOXSI3_T4D6.fits'

; ******************************************
; Plotting using foxsi-science
; ******************************************
@param2018_20181003.pro
restore, 'data_2018/foxsi_level2_data.sav'
; ***************************
; Target1 - AR
; ***************************
;T1D0
data_lvl2_D0.wsmr_time = 2.*data_lvl2_D0.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D0, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80] )
map2fits,m,'T1D0.fits'
;T1D2
data_lvl2_D2.wsmr_time = 2.*data_lvl2_D2.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D2, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80] )
map2fits,m,'T1D2.fits'
;T1D3
data_lvl2_D3.wsmr_time = 2.*data_lvl2_D3.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D3, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80],/cdte )
map2fits,m,'T1D3.fits'
;T1D4
data_lvl2_D4.wsmr_time = 2.*data_lvl2_D4.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D4, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80] )
map2fits,m,'T1D4.fits'
;T1D5
data_lvl2_D5.wsmr_time = 2.*data_lvl2_D5.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D5, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80],/cdte )
map2fits,m,'T1D5.fits'
;T1D6
data_lvl2_D6.wsmr_time = 2.*data_lvl2_D6.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D6, cen1_pos0, trange=[t1_start, t1_end], ERANGE=[0,80] )
map2fits,m,'T1D6.fits'
; ***************************
; Target2 - NP
; ***************************
;T2D0
data_lvl2_D0.wsmr_time = 2.*data_lvl2_D0.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D0, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80] )
map2fits,m,'T2D0.fits'
;T2D2
data_lvl2_D2.wsmr_time = 2.*data_lvl2_D2.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D2, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80] )
map2fits,m,'T2D2.fits'
;T2D3
data_lvl2_D3.wsmr_time = 2.*data_lvl2_D3.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D3, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80],/cdte )
map2fits,m,'T2D3.fits'
;T2D4
data_lvl2_D4.wsmr_time = 2.*data_lvl2_D4.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D4, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80] )
map2fits,m,'T2D4.fits'
;T2D5
data_lvl2_D5.wsmr_time = 2.*data_lvl2_D5.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D5, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80],/cdte )
map2fits,m,'T2D5.fits'
;T2D6
data_lvl2_D6.wsmr_time = 2.*data_lvl2_D6.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D6, cen2_pos0, trange=[t2_start, t2_end], ERANGE=[0,80] )
map2fits,m,'T2D6.fits'
; ***************************
; Target3 - QS
; ***************************
;T3D0
data_lvl2_D0.wsmr_time = 2.*data_lvl2_D0.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D0, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80] )
map2fits,m,'T3D0.fits'
;T3D2
data_lvl2_D2.wsmr_time = 2.*data_lvl2_D2.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D2, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80] )
map2fits,m,'T3D2.fits'
;T3D3
data_lvl2_D3.wsmr_time = 2.*data_lvl2_D3.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D3, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80],/cdte )
map2fits,m,'T3D3.fits'
;T3D4
data_lvl2_D4.wsmr_time = 2.*data_lvl2_D4.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D4, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80] )
map2fits,m,'T3D4.fits'
;T3D5
data_lvl2_D5.wsmr_time = 2.*data_lvl2_D5.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D5, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80],/cdte )
map2fits,m,'T3D5.fits'
;T3D6
data_lvl2_D6.wsmr_time = 2.*data_lvl2_D6.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D6, cen3_pos0, trange=[t3_start, t3_end], ERANGE=[0,80] )
map2fits,m,'T3D6.fits'
; ***************************
; Target4 - ARPos0
; ***************************
;T4D0
data_lvl2_D0.wsmr_time = 2.*data_lvl2_D0.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D0, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80] )
map2fits,m,'T40D0.fits'
;T4D2
data_lvl2_D2.wsmr_time = 2.*data_lvl2_D2.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D2, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80] )
map2fits,m,'T40D2.fits'
;T4D3
data_lvl2_D3.wsmr_time = 2.*data_lvl2_D3.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D3, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80],/cdte )
map2fits,m,'T40D3.fits'
;T4D4
data_lvl2_D4.wsmr_time = 2.*data_lvl2_D4.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D4, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80] )
map2fits,m,'T40D4.fits'
;T4D5
data_lvl2_D5.wsmr_time = 2.*data_lvl2_D5.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D5, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80],/cdte )
map2fits,m,'T40D5.fits'
;T4D6
data_lvl2_D6.wsmr_time = 2.*data_lvl2_D6.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D6, cen4_pos0, trange=[t4_pos0_start, t4_pos0_end], ERANGE=[0,80] )
map2fits,m,'T40D6.fits'
; ***************************
; Target4 - ARPos1
; ***************************
;T4D0
data_lvl2_D0.wsmr_time = 2.*data_lvl2_D0.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D0, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80] )
map2fits,m,'T41D0.fits'
;T4D2
data_lvl2_D2.wsmr_time = 2.*data_lvl2_D2.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D2, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80] )
map2fits,m,'T41D2.fits'
;T4D3
data_lvl2_D3.wsmr_time = 2.*data_lvl2_D3.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D3, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80],/cdte )
map2fits,m,'T41D3.fits'
;T4D4
data_lvl2_D4.wsmr_time = 2.*data_lvl2_D4.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D4, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80] )
map2fits,m,'T41D4.fits'
;T4D5
data_lvl2_D5.wsmr_time = 2.*data_lvl2_D5.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D5, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80],/cdte )
map2fits,m,'T41D5.fits'
;T4D6
data_lvl2_D6.wsmr_time = 2.*data_lvl2_D6.frame_counter /1000. + 48617.74 ; in seconds
m = foxsi_image_map( data_lvl2_D6, cen4_pos1, trange=[t4_pos1_start, t4_pos1_end], ERANGE=[0,80] )
map2fits,m,'T41D6.fits'











 

 
 
 
 
 
 

; ******************************************
; Plotting
; ******************************************
; Times:
date=anytim('2018-sep-7')
t0 = '7-Sep-2018 19:21:00.000'
framecounter = data_lvl2_d0.frame_counter - data_lvl2_d0[0].frame_counter
time_elp = 2.*framecounter /1000. ; in seconds
time = time_elp + 70.4919 ; in seconds
; Targets periods of observation
dt1 = 120.
dt2 = 30.
dt3 = 150.
dt4 = 60.
; Targets times
t1beg = (110.+4.)        			; in seconds
t1end = (110.+dt1-2.)		    	; in seconds
t2beg = (110.+dt1+4.)           	; in seconds
t2end = (110.+dt1+dt2-2.)	    	; in seconds
t3beg = (110.+dt1+dt2+4.)	    	; in seconds
t3end = (110.+dt1+dt2+dt3-2.)		; in seconds
t4beg = (110.+dt1+dt2+dt3+4.)		; in seconds
t4end = (110.+dt1+dt2+dt3+dt4-2.)	; in seconds
; tranges
tr1 = where(time ge t1beg AND time le t1end)
tr2 = where(time ge t2beg AND time le t2end)
tr3 = where(time ge t3beg AND time le t3end)
tr4 = where(time ge t4beg AND time le t4end)
; AR
t1range=[t1beg,t1end]
cen1 = [0,0]
loadct, 2
reverse_ct
m0 = foxsi_image_map( data_lvl2_d0, cen1, erange=[5.,10.], trange=trange, thr_n=4.)



















loadct, 2
reverse_ct
trange=[t1_pos2_start,t1_pos2_end]
m0 = foxsi_image_map( data_lvl2_d0, cen1_pos2, erange=[5.,10.], trange=trange, thr_n=4., /xycorr )
plot_map, m0, /limb, lcol=255, col=255, charsi=1.2, title=m0.id
draw_fov,det=0,target=1
map2fits,m0,'foxsi_d0.fits'


; **********************************************

; selection of good events and look at their energy
;----------------------------------------------------
;
goodevents = where(lvl2.error_flag eq 0) 
;minmax(lvl2[goodevents].hit_energy[1])
;
energygood1 = lvl2[goodevents].hit_energy[1]
histoe1 = histogram(energygood1, locations=xbins1)
energygood0 = lvl2[goodevents].hit_energy[0]
histoe0 = histogram(energygood0, locations=xbins0)

loadct,12
th=4
plot, xbins1, histoe1, xth=th, yth=th, th=th, psym=10, charth=th, chars=2.5, xr=[-1,180], xtitle='Energy [keV]', ytitle='number of counts', title='det 0, target 1', background=255, color=0
oplot, xbins1, histoe1, th=th, psym=10, color=100
oplot, xbins0, histoe0, th=th, psym=10, color=30
al_legend, ['p side','n side'], color=[100,30], linestyle=0, th=th, charth=th, chars=2.5, box=0

s = scatterplot(lvl2[goodevents].hit_energy[0], lvl2[goodevents].hit_energy[1], xtitle='Energy [keV], n side', ytitle='Energy [keV], p side', aspect_ratio=1, dime=[1500,900], sym_size=1, sym_thick=4, xr=[-10,200], yr=[-10,100], sym='o', /sym_filled, title='detector 0, good events')




;---------------------------------------------------------------
; plot lvl2 images GROUND
;---------------------------------------------------------------
.reset
restore, 'data_2018/foxsi_level2_data.sav'
lvl2 = data_lvl2_d0
;
; define time for imaging
;-----------------------------
framecounter = data_lvl2_d0.frame_counter - data_lvl2_d0[0].frame_counter
time_elp = 2.*framecounter /60. /1000. ; in minutes
time = time_elp + 1.1748650 ; in minutes

dt1 = 120.
dt2 = 30.
dt3 = 150.
dt4 = 60.

t1beg = (110.+4.)/60.         		; in minutes
t1end = (110.+dt1-2.)/60.		    ; in minutes
t2beg = (110.+dt1+4.)/60.	        ; in minutes
t2end = (110.+dt1+dt2-2.)/60.	    ; in minutes
t3beg = (110.+dt1+dt2+4.)/60.	        ; in minutes
t3end = (110.+dt1+dt2+dt3-2.)/60.	    ; in minutes
t4beg = (110.+dt1+dt2+dt3+4.)/60.	; in minutes
t4end = (110.+dt1+dt2+dt3+dt4-2.)/60.	; in minutes

tr1 = where(time ge t1beg AND time le t1end)
tr2 = where(time ge t2beg AND time le t2end)
tr3 = where(time ge t3beg AND time le t3end)
tr4 = where(time ge t4beg AND time le t4end)

foxsi3_lvl2_ground_image, data_lvl2_d0, minmax(tr4), image, pay=1, plot_im=plot_im, title='lvl2'


;work on error flag
;---------------------

lvl2 = data_lvl2_d0

detnum = lvl2[0].det_num
;sophie_linecolors
loadct,1
th=4
error_histo = histogram(lvl2.error_flag, locations = eloc)
plot, eloc, error_histo, xth=th, yth=th, th=th, psym=10, charth=th, chars=2.5, xtitle='Error flag number', ytitle='number of occurences', title='error flag, det '+strtrim(detnum,2), background=255, color=0

ef = lvl2.error_flag
EFF = foxsi3_error_flag_analysis(FIX(ef))

; level2 image
;---------------

foxsi3_lvl2_ground_image, lvl2, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2'

















