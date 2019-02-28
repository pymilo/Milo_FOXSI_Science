;; Making masks for FOXSI2-T4
;; You need to install and run the FOXSIScienceSoft
;; in your SSWIDL shell.
;; charge the FOXSI 2014 flight: $ foxsi,2014
;:
;;
;;

loadct, 2
reverse_ct

;; Select and Plot a FOXSI Target
trange=[t4_start,t4_end]
m = foxsi_image_map( data_lvl2_d0, cen4, erange=[5.,10.], trange=trange, thr_n=4.,/xycorr)
plot_map, m,/limb, lcol=255, col=255, charsi=1.2, title=m.id
draw_fov,det=0,target=4,shift=shift0
tvcircle,[540],-310,290,/data


;; Select circular area of interest
area_center = [0.,0.]
area_radius = [970.]
data = area_cut( data_lvl2_d5, area_center, area_radius, /xycorr)
data = area_cut2( data, [-310,290], [540.],/xycorr)
data = time_cut( data, trange[0], trange[1], energy=[5.,10.] )
m = foxsi_image_map(data, cen4, erange=[5.,10.], trange=trange, thr_n=4.,/xycorr)
plot_map, m, /limb, lcol=255, col=255, charsi=1.2, title=m.id
draw_fov,det=5,target=4,shift=shift5
tvcircle,area_radius,area_center[0],area_center[1],/data
tvcircle,[540],-310,290,/data


;; Select circular area of interest
area_center = [0.,0.]
area_radius = [970.]
data = area_cut2( data_lvl2_d6, [-240,350], [580.],/xycorr)
data = time_cut( data, trange[0], trange[1], energy=[5.,10.] )
m = foxsi_image_map(data, cen4, erange=[5.,10.], trange=trange, thr_n=4.,/xycorr)
plot_map, m, /limb, lcol=255, col=255, charsi=1.2, title=m.id
draw_fov,det=6,target=4,shift=shift6
tvcircle,area_radius,area_center[0],area_center[1],/data
tvcircle,[580],-240,350,/data







datat = time_cut( data_lvl2_d1, trange[0], trange[1], energy=[5.,10.] )
n_all = n_elements( datat )
n_good = n_elements( datat[ where( datat.error_flag eq 0 ) ] )
good_fraction = double(n_good) / n_all
print, 'Good Fraction = ',good_fraction
print, 'Counts = ', n_elements( data[ where( data.error_flag eq 0 ) ] )

