;----------------------------------------------------------------------------------------------
; precip_hov_4pan_horiz.ncl
;
; creates a 4 panel plot of hovmoller diagrams for the E25, E25 LWCRE-off, P25 LWCRE-off, and 
; P25 experiments
; the hovmoller show the first 3 years of data
;
; to plot a cleaner looking and much larger image comment out RasterFill
;
; this figure was generate in the review process of Silvers and Robinson 2020, 
; as submitted to JAMES
;
; levi silvers                                                                     august 2020
;----------------------------------------------------------------------------------------------

; load necessary libraries
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

path_to_wc="/Users/silvers/data"
exdir="/WalkerCell/testing_20181203"

fileout="hov_precip_25km"
plottitle="test title tude"
endtime=1800
;endtime=1090
;var1="prec_ls" ; time, grid_y, grid_x
;var1="prec_conv" ; time, grid_y, grid_x
var1="precip"
;var1="olr" ; time, grid_y, grid_x
dom_x=1 ; 1 is default and corresponds to a domain size of 4000km

hor_x_a=ispan(25,4000,25)
; P25
incoming_a=path_to_wc+exdir+"/c8x160L33_am4p0_25km_wlkr_ent0p9/"+"1979th1983_daily.nc"

hor_x_b=hor_x_a
; E25 
incoming_b=path_to_wc+exdir+"/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/"+"1979th1983_daily.nc"

hor_x_c=hor_x_a
; P25 lwoff
incoming_c=path_to_wc+exdir+"/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/"+"1979th1983_daily.nc"

hor_x_d=hor_x_a
; E25 lwoff conv off
incoming_d=path_to_wc+exdir+"/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/"+"1979th1983_daily.nc"

print("infile is: "+incoming_a)

infile_new_a=incoming_a
infile_new_b=incoming_b
infile_new_c=incoming_c
infile_new_d=incoming_d

scale=86400
;scale=1 ; works well for olr

; for incoming_a
data_a = addfile(infile_new_a,"r")
field_a = data_a->$var1$(1:endtime,:,:)
  print("dimsizes of field_a are: "+dimsizes(field_a))
p_ina_xt=dim_avg_n(field_a,1)
p_a_xt=scale*p_ina_xt

p_a_xt!0="time"
p_a_xt!1="xdim"
p_a_xt&xdim=hor_x_a

; for incoming_b
data_b = addfile(infile_new_b,"r")
field_b = data_b->$var1$(1:endtime,:,:)
  print("dimsizes of field_b are: "+dimsizes(field_b))
p_inb_xt=dim_avg_n(field_b,1)
p_b_xt=scale*p_inb_xt

p_b_xt!0="time"
p_b_xt!1="xdim"
p_b_xt&xdim=hor_x_b

; for incoming_c
data_c = addfile(infile_new_c,"r")
field_c = data_c->$var1$(1:endtime,:,:)
  print("dimsizes of field_c are: "+dimsizes(field_c))
p_inc_xt=dim_avg_n(field_c,1)
p_c_xt=scale*p_inc_xt

p_c_xt!0="time"
p_c_xt!1="xdim"
p_c_xt&xdim=hor_x_c

  print("---------------------------------------------")
  print("max of p_c is: "+max(p_c_xt))
  print("dimsizes of p_c_xt are: "+dimsizes(p_c_xt))
  print("---------------------------------------------")

; for incoming_d
data_d = addfile(infile_new_d,"r")
field_d = data_d->$var1$(1:endtime,:,:)
  print("dimsizes of field_d are: "+dimsizes(field_d))
p_ind_xt=dim_avg_n(field_d,1)
p_d_xt=scale*p_ind_xt

p_d_xt!0="time"
p_d_xt!1="xdim"
p_d_xt&xdim=hor_x_d

  print("---------------------------------------------")
  print("max of p_d is: "+max(p_d_xt))
  print("dimsizes of p_d_xt are: "+dimsizes(p_d_xt))
  print("---------------------------------------------")

;---------------------------------------------------------------------------
; make the plot(s)
;---------------------------------------------------------------------------

;plot_type="newPDF"
plot_type="eps"
;plot_type="png"
wks = gsn_open_wks(plot_type,fileout)

; original
my_levels1 = (/1,5,10,15,20, \
               25,30,35,40,45, \
               50,55,60,65,70, \
               75,80,85,90,95/); 

my_colors1 = (/111,121,124,134,159, \
               166,173,180,186,193, \
               200,205,210,215,220, \
               225,230,235,240,245, \
               255 /);,211,216/) ; 

my_levels2 = (/1,5,10,15,20, \
               30,40, \
               50,60,70, \
               80,90/); \

my_colors2 = (/0,111,124,134,159, \
                173,186, \
                200,210,220, \
                230,240, \
                255 /);,211,216/) ; 

gsn_define_colormap(wks,"amwg256")
plot = new(4,graphic)

testw=0.2
testh=0.65

; create resource for plot
 res                  = True     

 res@gsnDraw          = False
 res@gsnFrame         = False

; set up vertical axis limits
 res@cnInfoLabelOn            = False
 res@cnFillOn                 = True 
 res@cnFillMode               = "RasterFill"       ; Raster Mode
 ;res@cnFillMode               = "CellFill"       
 ;res@cnFillMode               = "AreaFill"       
 ;res@cnRasterSmoothingOn      = True
 res@cnLinesOn                = False
 ;res@cnLevelSelectionMode = "ManualLevels"
 res@cnLevelSelectionMode = "ExplicitLevels"
 res@cnLevels            = my_levels2
 res@cnFillColors        = my_colors2
 res@cnLinesOn             = False
 res@trXMinF      = 2
 res@tmYROn       = False
 res@tmXTOn       = False
 res@tmXBMode     = "Explicit"
 res@tmXBMode     = "Explicit"
 res@tmYLLabelAngleF   = 90
 res@cnLineLabelInterval  = 0                   ; label every other line
 res@lbLabelBarOn      = False
 res@tiMainFontHeightF = 0.019
 res@tiXAxisFontHeightF = 0.015
 res@tiMainString      = "P25" 

; far left
 res@vpXF            =   0.09
 res@vpYF            =   0.85
 res@vpWidthF          = testw ; vpWidth and Height control box size
 res@vpHeightF         = testh ; default for both is 0.6 in NDC units

 res@trXMaxF      = 4000
 res@tmXTOn       = True
 res@tmXBValues   = (/5,1000,2000,3000,4000/)
 res@tmXTValues   = (/5,1000,2000,3000,4000/)
 res@tmXBLabels   = (/"","1 ","2 ","3 ",""/)

; these commands turn off/on the varname and units at top of image
 res@gsnLeftString = ""
 res@gsnRightString = ""
 res@tiXAxisString     = "10~S~3~N~ km"
 res@tiYAxisString     = "days "

 plot(0) = gsn_csm_contour(wks,p_a_xt,res) ; 100km resolution

; right 
 res@trXMaxF      = 4000
 res@tmXBValues   = (/5,1000,2000,3000,4000/)
 res@tmXTValues   = (/5,1000,2000,3000,4000/)
 res@tmXBLabels   = (/"","1 ","2 ","3 ",""/)
 res@tmYLLabelsOn = False
 res@tiXAxisString     = "10~S~3~N~ km"
 res@tiYAxisString     = " "
 res@tiMainFontHeightF = 0.019
 res@tiMainString      = "P25 LWCRE-off" 
 res@vpXF            =   0.53
 res@vpYF            =   0.85
 res@vpWidthF          = testw ; vpWidth and Height control box size
 res@vpHeightF         = testh ; default for both is 0.6 in NDC units
 
 plot(1) = gsn_csm_contour(wks,p_c_xt,res) ; large domain 25km resolution

; far right
  res@trXMaxF      = 4000
  res@tmXBValues   = (/5,1000,2000,3000,4000/)
  res@tmXTValues   = (/5,1000,2000,3000,4000/)
  res@tmXBLabels   = (/"","1 ","2 ","3 ",""/)
 res@tiXAxisString     = "10~S~3~N~ km"
 res@tiYAxisString     = "  "
 res@tiMainString      = "E25 LWCRE-off" 
 res@vpXF            =   0.75
 ;res@vpXF            =   0.31
 res@vpYF            =   0.85
 res@vpWidthF          = testw ; vpWidth and Height control box size
 res@vpHeightF         = testh ; default for both is 0.6 in NDC units
 
 plot(3) = gsn_csm_contour(wks,p_d_xt,res)

; left
  res@trXMaxF      = 4000
  res@tmXBValues   = (/5,1000,2000,3000,4000/)
  res@tmYLValues   = (/200,400,600,800,1000/)
  res@tmXTValues   = (/5,1000,2000,3000,4000/)
  res@tmXBLabels   = (/"","1 ","2 ","3 ",""/)
  res@tmYLLabels   = (/" "," "," "," "," "/)
 res@tiXAxisString     = "10~S~3~N~ km"
 res@tiYAxisString     = "  "
 res@tiMainString      = "E25" 
 res@vpXF            =   0.0
 res@vpYF            =   0.0
 res@vpWidthF          = testw ; vpWidth and Height control box size
 res@vpHeightF         = testh ; default for both is 0.6 in NDC units

 plot(2) = gsn_csm_contour(wks,p_b_xt,res) 

print("values of p_d_xt are: "+p_b_xt(34,:))

resP                         = True
resP@txString                = " " 
;resP@txString                = "good grief"
;resP@txString                = plottitle
resP@gsnPanelLabelBar        = True
resP@pmLabelBarWidthF    = 0.3
resP@pmLabelBarHeightF    = 0.06
resP@lbTitleOn           = True
resP@lbTitlePosition     = "Top"
resP@lbTitleString       = "mm/day"
resP@lbTitleFontHeightF  = 0.015
resP@lbLabelFontHeightF      = 0.015
resP@gsnPanelFigureStrings = (/"a","b","c","d"/)
resP@gsnPanelFigureStringsFontHeightF = 0.015
resP@amJust                = "TopLeft"

 gsn_panel(wks,plot,(/1,4/),resP)

;maximize_output(wks,resP)





end
