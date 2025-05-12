#!/bin/bash
# Opciones para depurar script
set -e
set -u

# Este script crea las condiciones iniciales necesarias previas para la ejecuci'on
# del pronostico HYCOM - 2025 (Se utiliza Climatologia HYCOM-IOA)
# TAREAS
# 1. Crea forzamientos
# 2. Crea archivo limits con la fecha en dias julianos 
MODELO_HYCOM=/LUSTRE/OPERATIVO/OPERATIVO2/modelos/HYCOM
cd $MODELO_HYCOM/expt_00.0

# Fecha actual de inicio de simulacion
ANIO_INI=$(date +%Y)
MES_INI=$(date +%m)
DIA_INI=$(date +%d)
HORA_INI=12
# Fecha de termino de simulacion (HYCOM)
ANIO_FIN=$(date +%Y --date='4 day')
MES_FIN=$(date +%m --date='4 day')
DIA_FIN=$(date +%d --date='4 day')
HORA_FIN=00

export fecha_ini=$ANIO_INI"-"$MES_INI"-"$DIA_INI"_"$HORA_INI
export fecha_fin=$ANIO_FIN"-"$MES_FIN"-"$DIA_FIN"_"$HORA_FIN

echo $fecha_ini $fecha_fin
python dias_jul.py $fecha_inicio $fecha_final
# 000y0250126012.limits
mv limits 000y0250126012.limits

# exit 1
# Ambiente de ejecuci'on
ml load herramientas/python/latest
python force2ab_operativo.py $fecha_ini 025 0126012

# Crear restart
cd $MODELO_HYCOM/restart/000

# Correr modelo
# Verificar que condiciones esten cumplidas
# Correr el modelo
#ml purge
#ml use /opt/apps/modulefiles
#ml pronostico/v4
#ml intel/2022u2/compilers mpi
#cd /LUSTRE/OPERATIVO/OPERATIVO2/modelos/HYCOM/expt_00.0
#/bin/csh 000y022_mas12o.csh > /tmp/HYCOM/salida_ex-forecast.prueba.$(date +%Y%m%d%H%M%S) 2>&1
(END)
