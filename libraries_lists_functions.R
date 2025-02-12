library(tidyverse)
library(ggthemes)
library(readxl)
library(lubridate)

final_theme=theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        plot.title=element_text(size=16, face='bold', hjust=0.5)) #save as a grom

#lists for columns
varnames2021 <- c('datetime', 'bat_v', 'do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m', 
                  'dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m', 'do_ppm_32m', 'dotemp_C_32m', 
                  'do_sat_pct_32m', 'temp_C_0.5m', 'temp_C_1m', 'temp_C_2m', 'temp_C_4m', 
                  'temp_C_6m', 'temp_C_8m', 'temp_C_10m', 'temp_C_12m', 'temp_C_16m', 
                  'temp_C_22m', 'temp_C_30m', 'wind_dir_deg', 'wind_sp_mps', 'ave_wind_sp_mps', 
                  'air_temp_degC', 'rel_hum_perc', 'bar_press_mmhg', 'daily_cum_rain_cm')
varnames2018 <- c('datetime', 'bat_v', 'do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m', 
                  'dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m', 'do_ppm_32m', 'dotemp_C_32m', 
                  'do_sat_pct_32m', 'temp_C_0.5m', 'temp_C_1m', 'temp_C_2m', 'temp_C_4m', 
                  'temp_C_6m', 'temp_C_8m', 'temp_C_10m', 'temp_C_12m', 'temp_C_16m', 
                  'temp_C_22m', 'temp_C_30m')
varnames2017 <- c('datetime', 'bat_v', 'do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m', 
                  'dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m', 'do_ppm_32m', 'dotemp_C_32m', 
                  'do_sat_pct_32m', 'temp_C_0.5m', 'temp_C_1m', 'temp_C_2m', 'temp_C_4m', 
                  'temp_C_6m', 'temp_C_8m', 'temp_C_10m', 'temp_C_12m', 'temp_C_16m', 
                  'temp_C_22m', 'temp_C_30m')
varnames2016 <- c("datetime", "bat_v", "dotemp_C_1m", "do_sat_pct_1m", "do_ppm_1m", 
                  "dotemp_C_14.5m", "do_sat_pct_14.5m", "do_ppm_14.5m", "dotemp_C_32m", "do_sat_pct_32m", 
                  "do_ppm_32m", "temp_C_0.5m", "temp_C_1m", "temp_C_2m", "temp_C_4m", 
                  "temp_C_6m", "temp_C_8m", "temp_C_10m", "temp_C_12m", "temp_C_16m", 
                  "temp_C_22m", "temp_C_30m")
varnames2015 <- c("datetime", "bat_v", "dotemp_C_1m", "do_sat_pct_1m", "do_ppm_1m", 
                  "dotemp_C_14.5m", "do_sat_pct_14.5m", "do_ppm_14.5m", "dotemp_C_32m", "do_sat_pct_32m", 
                  "do_ppm_32m", "temp_C_0.5m", "temp_C_1m", "temp_C_2m", "temp_C_4m", 
                  "temp_C_6m", "temp_C_8m", "temp_C_10m", "temp_C_12m", "temp_C_16m", 
                  "temp_C_22m", "temp_C_30m")
varnames2014 <- c("datetime", "bat_v", "dotemp_C_1m", "do_sat_pct_1m", "do_ppm_1m", 
                  "dotemp_C_14.5m", "do_sat_pct_14.5m", "do_ppm_14.5m", "dotemp_C_32m", "do_sat_pct_32m", 
                  "do_ppm_32m", "temp_C_0.5m", "temp_C_1m", "temp_C_2m", "temp_C_4m", 
                  "temp_C_6m", "temp_C_8m", "temp_C_10m", "temp_C_12m", "temp_C_16m", 
                  "temp_C_22m", "temp_C_30m")
varnames2013 <- c("datetime", "bat_v", "dotemp_C_1m", "do_sat_pct_1m", "do_ppm_1m", 
                  "dotemp_C_14.5m", "do_sat_pct_14.5m", "do_ppm_14.5m", "dotemp_C_32m", "do_sat_pct_32m", 
                  "do_ppm_32m", "temp_C_0.5m", "temp_C_1m", "temp_C_2m", "temp_C_4m", 
                  "temp_C_6m", "temp_C_8m", "temp_C_10m", "temp_C_12m", "temp_C_16m", 
                  "temp_C_22m", "temp_C_30m")
met2020 <- c('datetime', 'bat_v', 'wind_dir_deg', 'wind_sp_mps', 'ave_wind_sp_mps', 
             'air_temp_degC', 'rel_hum_perc', 'bar_press_mmhg', 'daily_cum_rain_cm')


#lists for cleaning
do <- c('do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m', 
        'dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m', 
        'do_ppm_32m', 'dotemp_C_32m', 'do_sat_pct_32m')
do1 <- c('do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m')
do14 <- c('dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m')
do32 <- c('do_ppm_32m', 'dotemp_C_32m', 'do_sat_pct_32m')
therm <- c('temp_C_0.5m', 'temp_C_1m', 'temp_C_2m', 'temp_C_4m', 
           'temp_C_6m', 'temp_C_8m', 'temp_C_10m', 'temp_C_12m', 'temp_C_16m', 
           'temp_C_22m', 'temp_C_30m')
weather <- c('wind_dir_deg', 'wind_sp_mps', 'ave_wind_sp_mps', 
             'air_temp_degC', 'rel_hum_perc', 'bar_press_mmhg', 'daily_cum_rain_cm')
weather_proc <- c('wind_dir_deg', 'wind_sp_mps', 'ave_wind_sp_mps', 
                  'air_temp_degC', 'rel_hum_perc', 'bar_press_mmhg', 'rain_cm')
wind <- c('wind_dir_deg', 'wind_sp_mps', 'ave_wind_sp_mps')
do1m = c('do_ppm_1m', 'dotemp_C_1m', 'do_sat_pct_1m')
do14m = c('dotemp_C_14.5m', 'do_sat_pct_14.5m', 'do_ppm_14.5m')
