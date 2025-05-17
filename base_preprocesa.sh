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
#cd $MODELO_HYCOM/expt_00.0

# Fecha actual como inicio de simulacion
ANIO=$(date +%Y)
MES=$(date +%m)
DIA=$(date +%d)
HORA=12
# horas de simulación
HORAS=84

python fmt_fechas.py "$ANIO"-"$MES"-"$DIA"_"$HORA" $HORAS

# carga .env con variables creadas
set -a
source .env
set +a

echo $fecha_ini $fecha_fin

echo "SIGUIENTE ETAPA. CORRER MODELO"
exit 1
# Ambiente de ejecuci'on
ml load herramientas/python/latest
#python force2ab_operativo.py $fecha_ini $P_YEAR "0${DAYS_SINCE_JAN_1}012" > 000y0250126012
python force2ab_operativo.py $fecha_ini $P_YEAR "0${DAYS_SINCE_JAN_1}012" > $LIMITS

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
