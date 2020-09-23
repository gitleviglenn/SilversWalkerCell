NetCDF files in these directories to reproduce the results of Silvers and Robinson (2020), "Clouds and Radiation in a mock-Walker Circulation".
published in the Journal of Advances in Modeling Earth Systems (JAMES)

For questions please contact Levi Silvers at levi.silvers@stonybrook.edu

#=========================================================================================
# data for the P100, P100L, P25, P25L, E25 experiments are in the following directories 
#=========================================================================================
# P100
c8x40L33_am4p0_100km_wlkr_ent0p9
c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff
# P100L
c8x160L33_am4p0_100km_wlkr_ent0p9
c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff
# P25
c8x160L33_am4p0_25km_wlkr_ent0p9
c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff
# P25L
c8x640L33_am4p0_25km_wlkr_ent0p9
c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff
# E25
c8x160L33_am4p0_25km_wlkr_ent0p9_noconv
c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff

# within the directories for each of these experiments: P100, P100L, P25, P25L, E25
# there are two files: 1979th1983_daily.nc and 1980th1983.atmos_month_tmn.nc

# within each of these files are the following variables: 
1979th1983_daily.nc
'prec_conv'
'prec_ls'
'precip'

1980th1983.atmos_month_tmn.nc
'ps'
'temp'
'ucomp'
'w'
'sphum'
'cld_amt'
'z_full'
'precip'
'prec_conv'
'prec_ls'
'rh'
'tot_liq_amt'
'tot_ice_amt'
'tdt_lw'
'evap'
'shflx'


#=========================================================================================
# data for the E1 and E2 experiments are in the following directories 
#=========================================================================================
# E1 
c10x4000L33_am4p0_1km_wlkr_4K
c10x4000L33_am4p0_1km_wlkr_4K_lwoff
# E2 
c50x2000L33_am4p0_2km_wlkr_4K
c50x2000L33_am4p0_2km_wlkr_4K_lwoff

# within each of these directories are two files: 1979_6mn.atmos_month.nc and 1979.6mn.atmos_daily_selvars.nc
# these files contain the following variables: 

# 1979_6mn.atmos_month.nc
tdt_lw
t_surf
evap
shflx
tot_ice_amt
tot_liq_amt
rh
precip
z_full
cld_amt
sphum
ucomp
temp 
w
ps
shflx

# 1979.6mn.atmos_daily_selvars.nc
t_surf
ps
precip












