;------------------------------------------------------------------------------
; always run these lines before starting any analysis (on Sophie's computer)
;------------------------------------------------------------------------------

f = 'data_180907_111001'
dir = 'C:\Users\SMusset\Documents\RESEARCH\FOXSI\Calibration_and_Flight_activities\Lab_and_calibration\Calibration data and plots\wsmr\20180907\'

science_dir = 'C:\Users\SMusset\Documents\RESEARCH\FOXSI\Science_Analysis\foxsi-science\'

add_path,'C:\Users\SMusset\Documents\RESEARCH\FOXSI\Calibration_and_Flight_activities\calsoft_copy\' ; find my own version of calsoft
add_path, science_dir										     ; my own version of the science soft
add_path, 'C:\Users\SMusset\Documents\GitHub\FOXSI3-analysis\'					     ; where I put the new routines developed before adding them to either calsoft or science soft

cd, dir												     ; I am in the folder containing the data

;------------------------------------------------------------------------------
; create IDL sav files from the dat file
;------------------------------------------------------------------------------

detnum = 0			
name = 'D'+strtrim(detnum,2)+'_'+f
str = 'struct_D'+strtrim(detnum,2)+'_'+f+'.dat'	
data = formatter_packet(dir+f+'.dat',detnum)		; process the binary data file
save, data,file=str

;------------------------------------------------------------------------------
; create lvl0 and lvl1 data - NO POINTING INFORMATION (GROUND)
;------------------------------------------------------------------------------

; CREATE AND SAVE LEVEL 0 DATA
;------------------------------

data_lvl0_D0 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=0)
data_lvl0_D1 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=1)
data_lvl0_D2 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=2)
data_lvl0_D3 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=3)
data_lvl0_D4 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=4)
data_lvl0_D5 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=5)
data_lvl0_D6 = FORMATTER_DATA_TO_LEVEL0(dir+f+'.dat', DETECTOR=6)

save, data_lvl0_D0, data_lvl0_D1, data_lvl0_D2, data_lvl0_D3, data_lvl0_D4, data_lvl0_D5, data_lvl0_D6, file = F+'_lvl0.sav'


; CREATE AND SAVE LEVEL 1 DATA: ONE SET WITH ALL DATA, THE SECOND SET WITH ONLY DATA WHERE HV=200
;-------------------------------------------------------------------------------------------------

LVL1 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = DETNUM, GROUND=1)

DATA_LVL1_D0 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 0, GROUND=1, only_hv=0)
DATA_LVL1_D2 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 2, GROUND=1, only_hv=0)
DATA_LVL1_D3 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 3, GROUND=1, /cdte, only_hv=0)
DATA_LVL1_D4 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 4, GROUND=1, only_hv=0)
DATA_LVL1_D5 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 5, GROUND=1, /cdte, only_hv=0)
DATA_LVL1_D6 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 6, GROUND=1, only_hv=0)

save, DATA_LVL1_D0, DATA_LVL1_D2, DATA_LVL1_D3, DATA_LVL1_D4, DATA_LVL1_D5, DATA_LVL1_D6, file=f+'_lvl1_allframes.sav'

DATA_LVL1_D0 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 0, GROUND=1, only_hv=1)
DATA_LVL1_D2 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 2, GROUND=1, only_hv=1)
DATA_LVL1_D3 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 3, GROUND=1, /cdte, only_hv=1)
DATA_LVL1_D4 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 4, GROUND=1, only_hv=1)
DATA_LVL1_D5 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 5, GROUND=1, /cdte, only_hv=1)
DATA_LVL1_D6 = FOXSI_LEVEL0_TO_LEVEL1(F+'_lvl0.sav', DETECTOR = 6, GROUND=1, only_hv=1)

save, DATA_LVL1_D0, DATA_LVL1_D2, DATA_LVL1_D3, DATA_LVL1_D4, DATA_LVL1_D5, DATA_LVL1_D6, file=f+'_lvl1.sav'


;----------------------------------------------------------------------------------
; lvl1 to lvl2 data - NO POINTING INFORMATION (GROUND)
;----------------------------------------------------------------------------------

FILE0 = f+'_lvl0.sav'
FILE1 = f+'_lvl1.sav'
cal0 = science_dir+'calibration_data\peaks_det105.sav'
cal2 = science_dir+'calibration_data\peaks_det106.sav'
cal4 = science_dir+'calibration_data\peaks_det102.sav'
cal6 = science_dir+'calibration_data\peaks_det101.sav'
data_lvl2_D0 = foxsi_level1_to_level2( file0, file1, det=0, calib=cal0, year=2018, ground=1 )
data_lvl2_D2 = foxsi_level1_to_level2( file0, file1, det=2, calib=cal2, year=2018, ground=1 )
data_lvl2_D4 = foxsi_level1_to_level2( file0, file1, det=4, calib=cal4, year=2018, ground=1 )
data_lvl2_D6 = foxsi_level1_to_level2( file0, file1, det=6, calib=cal6, year=2018, ground=1 )

save, data_lvl2_D0, data_lvl2_D2, data_lvl2_D4, data_lvl2_D6, file=f+'_lvl2_si_ground.sav'

;-------------------------------------------------------------------------------------
; extract HV data and plot over time - first try - DO NOT WORK WELL
;-------------------------------------------------------------------------------------
;
; HV = LVL1.HV
; Timeel = findgen(n_elements(lvl1))/500./60.
; PLOT, Timeel, hv, ytitle='High Voltage [V]', xtitle='Elapsed time [Minutes]', chars=2, ; thick=3, xth=2, yth=2, chart=2
; ; zoom on high voltage going to 200V
; PLOT, Timeel[358000:364590], hv[358000:364590], ytitle='High Voltage [V]', ; xtitle='Elapsed time [Minutes]', chars=2, thick=3, xth=2, yth=2, chart=2, yr=[-10,300]
;

;--------------------------------------------------------------------------------------------------------
; extract HV data from LVL1 data and plot hv evolution over time - extract problematic frame
;--------------------------------------------------------------------------------------------------------

; restore lvl1 file with all frames
restore, f+'_lvl1_allframes.sav'

; we have to ignore a frame for each detector but the frame number is different
;-------------------
;det0
lvl1 = data_lvl1_D0
hv = [ lvl1[0:363768].hv, lvl1[363770:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:363768].frame_counter, lvl1[363770:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter

;det2
lvl1 = data_lvl1_D2
hv = [ lvl1[0:363630].hv, lvl1[363632:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:363630].frame_counter, lvl1[363632:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter

; det6
hv = [ lvl1[0:364223].hv, lvl1[364225:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:364223].frame_counter, lvl1[364225:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter

; det4
hv = [ lvl1[0:364460].hv, lvl1[364462:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:364460].frame_counter, lvl1[364462:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter

; det3
hv = [ lvl1[0:444].hv, lvl1[446:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:444].frame_counter, lvl1[446:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter

; det5
hv = [ lvl1[0:1241].hv, lvl1[1243:n_elements(lvl1)-1].hv ]
frame_count = [ lvl1[0:1241].frame_counter, lvl1[1243:n_elements(lvl1)-1].frame_counter ] - lvl1[0].frame_counter
;-------------------

; then calculate time elapsed with frame number
time_elp = 2.*frame_count /60. /1000. ; in minutes

; plot hv versus time elapsed
plot, time_elp, hv, ytitle='High Voltage [V]', xtitle='Elapsed time [Minutes]', chars=2, thick=3, xth=2, yth=2, chart=2, yr=[-10,210]

; look for frame where we start ramping hv up
nozero = where(hv ne 0)
fff = foxsi3_first_indice_in_consec(nozero)

; use this information to find the frame of time = 0 (time of the launch)
time = time_elp - time_elp[fff[3]] + 0.5 ; for all det but det 3
;time = time_elp - time_elp[fff[2]] + 0.5 ; for CdTe det 3

; plot HV versus time with time origin = launch
plot, time, hv, ytitle='High Voltage [V]', xtitle='Elapsed time [Minutes]', chars=2, thick=3, xth=2, yth=2, chart=2, yr=[-10,210]
oplot, [0,0], [-50, 250], linestyle=1, thick=2
oplot, [110,110]/60., [-50, 250], linestyle=2, thick=2
oplot, ([110,110]+120)/60., [-50, 250], linestyle=2, thick=2
oplot, ([110,110]+120+30)/60., [-50, 250], linestyle=2, thick=2
oplot, ([110,110]+120+30+150)/60., [-50, 250], linestyle=2, thick=2
oplot, ([110,110]+120+30+150+60)/60., [-50, 250], linestyle=2, thick=2


;---------------------------------------------------------------
; find time at which HV=200 V
;---------------------------------------------------------------

hv200 = where(hv EQ 200)
print, time[hv200[0]]

t200det = [1.17090, 1.18033, 1.17873, 1.16950] ; those are the results for the 4 Si detectors
print, t200det*60.
t200 = mean(t200det)

;---------------------------------------------------------------
; find targets indices (using level1 data)
;---------------------------------------------------------------

launch = where(time gt 0.)
obs = where(time gt 110./60.)
target2 = where(time gt (110.+120)/60.)
target3 = where(time gt (110.+120+30)/60.)
target4 = where(time gt (110.+120+30+150)/60.)
ENDobs = where(time gt (110.+120+30+150+60)/60.)

print, 'target 1 indices ', obs[0], target2[0]-1
print, 'target 2 indices ', target2[0], target3[0]-1
print, 'target 3 indices ', target3[0], target4[0]-1
print, 'target 4 indices ', target4[0], endobs[0]-1

; assuming 4 sec pointing at beginning of target 
; and 2 second uncertainty at the end

dt1 = 120.
dt2 = 30.
dt3 = 150.
dt4 = 60.

target1beg = where(time gt (110.+4.)/60.)
target1end = where(time gt (110.+dt1-2.)/60.)
target2beg = where(time gt (110.+dt1+4.)/60.)
target2end = where(time gt (110.+dt1+dt2-2.)/60.)
target3beg = where(time gt (110.+dt1+dt2+4.)/60.)
target3end = where(time gt (110.+dt1+dt2+dt3-2.)/60.)
target4beg = where(time gt (110.+dt1+dt2+dt3+4.)/60.)
target4end = where(time gt (110.+dt1+dt2+dt3+dt4-2.)/60.)

print, 'target 1 indices ', target1beg[0], target1end[0]
print, 'target 2 indices ', target2beg[0], target2end[0]
print, 'target 3 indices ', target3beg[0], target3end[0]
print, 'target 4 indices ', target4beg[0], target4end[0]

target1 = [target1beg[0], target1end[0]]
target2 = [target2beg[0], target2end[0]]
target3 = [target3beg[0], target3end[0]]
target4 = [target4beg[0], target4end[0]]

;-----------------------------------------------------------
; plot image with LVL1 data 
;-----------------------------------------------------------

foxsi3_lvl1_image, lvl1, 0, [363860,364042],im, pay=1, phys=1, plot_im=1

; target 1

foxsi3_lvl1_image, data_lvl1_D0, 0, [363860,364042],im, pay=1, phys=0, plot_im=1, title=', target 1'
foxsi3_lvl1_image, data_lvl1_D2, 2, [363705,363894],im, pay=1, phys=0, plot_im=1, title=', target 1'
foxsi3_lvl1_image, data_lvl1_D3, 3, [535,689],      im, pay=1, phys=0, plot_im=1, title=', target 1', cdte=1
foxsi3_lvl1_image, data_lvl1_D4, 4, [364512,364645],im, pay=1, phys=0, plot_im=1, title=', target 1'
foxsi3_lvl1_image, data_lvl1_D5, 5, [1325,1464],    im, pay=1, phys=0, plot_im=1, title=', target 1', cdte=1
foxsi3_lvl1_image, data_lvl1_D6, 6, [367917,390593],im, pay=1, phys=0, plot_im=1, title=', target 1'

; target 4

foxsi3_lvl1_image, data_lvl1_D0, 0, [364351,364432],im, pay=1, phys=0, plot_im=1, title=', target 4'
foxsi3_lvl1_image, data_lvl1_D2, 2, [364152,364214],im, pay=1, phys=0, plot_im=1, title=', target 4'
foxsi3_lvl1_image, data_lvl1_D3, 3, [949,1033],     im, pay=1, phys=0, plot_im=1, title=', target 4', cdte=1
foxsi3_lvl1_image, data_lvl1_D4, 4, [364851,364905],im, pay=1, phys=0, plot_im=1, title=', target 4'
foxsi3_lvl1_image, data_lvl1_D5, 5, [57824,58303],  im, pay=1, phys=0, plot_im=1, title=', target 4', cdte=1
foxsi3_lvl1_image, data_lvl1_D6, 6, [465457,490574],im, pay=1, phys=0, plot_im=1, title=', target 4'


;---------------------------------------------------------------
; plot lvl2 images GROUND
;---------------------------------------------------------------
restore, f+'_lvl2_si_ground.sav'

lvl2 = data_lvl2_d0


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
t1end = (110.+dt1-2.)/60.		; in minutes
t4beg = (110.+dt1+dt2+dt3+4.)/60.	; in minutes
t4end = (110.+dt1+dt2+dt3+dt4-2.)/60.	; in minutes

tr1 = where(time ge t1beg AND time le t1end)
tr4 = where(time ge t4beg AND time le t4end)

; selection of good events and look at their energy
;----------------------------------------------------

goodevents = where(lvl2.error_flag eq 0) 
;minmax(lvl2[goodevents].hit_energy[1])

energygood1 = lvl2[goodevents].hit_energy[1]
histoe1 = histogram(energygood1, locations=xbins1)
energygood0 = lvl2[goodevents].hit_energy[0]
histoe0 = histogram(energygood0, locations=xbins0)

sophie_linecolors
th=4
plot, xbins1, histoe1, xth=th, yth=th, th=th, psym=10, charth=th, chars=2.5, xr=[-1,180], xtitle='Energy [keV]', ytitle='number of counts', title='det 0, target 1', background=1, color=0
oplot, xbins1, histoe1, th=th, psym=10, color=10
oplot, xbins0, histoe0, th=th, psym=10, color=3
al_legend, ['p side','n side'], color=[10,3], linestyle=0, th=th, charth=th, chars=2.5, box=0

s = scatterplot(lvl2[goodevents].hit_energy[0], lvl2[goodevents].hit_energy[1], xtitle='Energy [keV], n side', ytitle='Energy [keV], p side', aspect_ratio=1, dime=[1500,900], sym_size=1, sym_thick=4, xr=[-10,200], yr=[-10,100], sym='o', /sym_filled, title='detector 0, good events')

; work on error flag
;---------------------

lvl2 = data_lvl2_d0

detnum = lvl2[0].det_num
sophie_linecolors
th=4
error_histo = histogram(lvl2.error_flag, locations = eloc)
plot, eloc, error_histo, xth=th, yth=th, th=th, psym=10, charth=th, chars=2.5, xtitle='Error flag number', ytitle='number of occurences', title='error flag, det '+strtrim(detnum,2), background=1, color=0

ef = lvl2.error_flag
EFF = foxsi3_error_flag_analysis(FIX(ef))

; level2 image
;---------------

foxsi3_lvl2_ground_image, lvl2, minmax(tr1), image, pay=1, plot_im=plot_im, title='lvl2'




