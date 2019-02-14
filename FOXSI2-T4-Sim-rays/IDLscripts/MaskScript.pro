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
m0 = foxsi_image_map( data_lvl2_d0, cen4, erange=[5.,10.], trange=trange, thr_n=4.,/xycorr)
plot_map, m0,/limb, lcol=255, col=255, charsi=1.2, title=m0.id
draw_fov,det=0,target=4,shift=shift0

m1 = foxsi_image_map( data_lvl2_d1, cen4, erange=[5.,10.], trange=trange, thr_n=4.,/xycorr)
plot_map, m1,/limb, lcol=255, col=255, charsi=1.2, title=m1.id
draw_fov,det=1,target=4,shift=shift1




;; Select circular area of interest
area_center = [200.,600.]
area_radius = [200.]
data = area_cut( data_lvl2_d1, area_center, area_radius, /xycorr)
data = time_cut( data, trange[0], trange[1], energy=[5.,10.] )
m = foxsi_image_map(data, cen4, erange=[5.,10.], trange=trange, thr_n=4., /xycorr )
plot_map, m, /limb, lcol=255, col=255, charsi=1.2, title=m1.id
draw_fov,det=1,target=4
tvcircle,area_radius,area_center[0],area_center[1],/data

datat = time_cut( data_lvl2_d1, trange[0], trange[1], energy=[5.,10.] )
n_all = n_elements( datat )
n_good = n_elements( datat[ where( datat.error_flag eq 0 ) ] )
good_fraction = double(n_good) / n_all
print, 'Good Fraction = ',good_fraction
print, 'Counts = ', n_elements( data[ where( data.error_flag eq 0 ) ] )

