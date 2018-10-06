PRO foxsi3_lvl1_image, lvl1file, detnum, trange, image, pay=pay, physical=physical, cdte=cdte, plot_im=plot_im, title=title

;+
; description  
;   This procedure takes a level1 foxsi3 file and return an image array
;
; input
;   lvl1file: the lvl1 file
;   detnum: detector position number
;   trange: time range, start and end indices in the lvl1 file
; 
; output
;   image: the image array
;   
; keywords
;   pay: if set, take the hit_xy_pay instead of hit
;   physical: if set, plot in physical coordinates
;   cdte: set to 1 for FOXSI3 cdte detector. Needed only if physical keyword is set
;   plot_im: if set, will plot the resulting image before closing
;   
; history
;   2018-Sep-20 Sophie creation of the procedure  
;-

; default and useful constants

DEFAULT, pay, 0
DEFAULT, physical, 0
DEFAULT, cdte, 0
DEFAULT, plot_im, 0
DEFAULT, title, 'target x'

IF physical EQ 1 then DET = 0
angle = [82.5000, 75.0000, -67.5000, -75.0000, 97.5000, 90.0000, -60.0000]

ct = colortable(1,/reverse)
nr = n_elements(lvl1file)

; initialisation of variables
img = fltarr(128,128)
ngood = 0
nbad = 0

; creating the image array in detector coordinates

FOR k=trange[0], trange[1] DO BEGIN
  IF lvl1file[k].error_flag NE 0 THEN NBAD= nbad +1 ELSE BEGIN
    ngood=ngood+1
    ;IF pay EQ 1 THEN coord = lvl1file[k].hit_xy_pay ELSE
     coord = lvl1file[k].hit_xy_det
    img[coord[0],coord[1]] = img[coord[0],coord[1]]+1
  ENDELSE
ENDFOR

print, ngood, ' good events and ', nbad, ' bad events'

; go in physical coordinates if keyword is set

IF physical EQ 1 THEN BEGIN
  ; mirror effect
  img = reverse(img,2)
  
  ; if cdte apply reflexion  
  IF cdte EQ 1 THEN img = reverse(img,2)

  ; change orientation
  img = rot(img, angle[detnum], /interp)

  ; print pixel size
  
ENDIF

XLIST = list()
YLIST = list()
IF pay EQ 1 THEN BEGIN
  FOR k=trange[0], trange[1] DO BEGIN
    IF lvl1file[k].error_flag NE 0 THEN NBAD= nbad +1 ELSE BEGIN
      ngood=ngood+1
      coord = lvl1file[k].hit_xy_pay
      xlist.add, coord[0]
      ylist.add, coord[1]
    ENDELSE
  endfor
  xcoor = xlist.toarray()
  ycoor = ylist.toarray()
  S = scatterplot(xcoor,ycoor, sym='+',aspect_ratio=1, dime=[1000,1000], title='det. num. '+strtrim(detnum,2)+title, sym_size=2, sym_thick=4, xtitle='arcsec', ytitle='arcsec')
  
ENDIF


; plot if needed
IF plot_im EQ 1 THEN BEGIN
  IF physical EQ 1 THEN subtitle = 'payload coordinates [arcsec]' ELSE subtitle='detector coordinates [pixels]'
  i = image(img, margin=0.1, rgb_table=ct, axis_style=2, dim=[1000,1000],xmajor=9, xminor=16, ymajor=9, yminor=16, title='det. num. '+strtrim(detnum,2)+title, xtitle=subtitle, ytitle=subtitle)
;  i = image(img, rgb_table=ct, title = ttle, dimensions=[1500,1500], margin=0.05)
ENDIF

image=img
END