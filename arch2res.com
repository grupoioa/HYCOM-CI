#!/bin/csh
#
set echo
#
# --- Form a HYCOM restart file from a HYCOM archive file.
# --- Defined in the same grid
#
#
# --- data directory
#
#setenv D /LUSTRE/CIGOM/HYCOM/EXPS_CURSO/hycom_2025/tutorial/restart/data
setenv D /LUSTRE/OPERATIVO/OPERATIVO2/modelos/HYCOM/nest
setenv R /LUSTRE/OPERATIVO/OPERATIVO2/modelos/HYCOM/restart/000
#
# ---  input archive file
# ---  input restart file
# --- output restart file
#
# /LUSTRE/CIGOM/HYCOM/EXPS_CURSO/hycom_2025/tutorial/HYCOM-tools/archive/src/archv2restart <<E-o-D
/LUSTRE/OPERATIVO/OPERATIVO2/OPERATIVO_HYCOM/HYCOM-tools/archive/src/archv2restart <<E-o-D
${D}/archv.100-103_a_L41.a 
${R}/restart_in.a
${R}/restart_07.a
000     'iexpt ' = experiment number x10 (000=from archive file)
  3     'yrflag' = days in year flag (0=360J16,1=366J16,2=366J01,3-actual)
541     'idm   ' = longitudinal array size
385     'jdm   ' = latitudinal  array size
  0     'kapref' = thermobaric ref. state (-1=input,0=none,1,2,3=constant)
36.0     'kdm   ' = number of layers
34.0   'thbase' = reference density (sigma units)
30.0   'baclin' = baroclinic time step (seconds), int. divisor of 86400
E-o-D
