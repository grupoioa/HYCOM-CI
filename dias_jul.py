# Conversion de fecha de ejecucion a julianos con # 
# fecha de referencia 31/12/1900 (HYCOM).         #

import datetime
import sys

#Definir fecha de referencia y fechas a calcular
dia_ref_cadena='1900-12-31_00'
fecha_inicio = sys.argv[1]
fecha_final = sys.argv[2]
# Automatizar declaracion de fechas
#fecha_inicio='2025-05-06_12'
#fecha_final='2025-05-10_00'

#Convertir a objetos tipo datetime
dia_ref=datetime.datetime.strptime(dia_ref_cadena,'%Y-%m-%d_%H')
dia_in=datetime.datetime.strptime(fecha_inicio,'%Y-%m-%d_%H')
dia_fin=datetime.datetime.strptime(fecha_final,'%Y-%m-%d_%H')

#Calcular las diferencias en dias
dif_dias_in=dia_in-dia_ref
dif_dias_fin=dia_fin-dia_ref

jul_in='{:.4f}'.format(dif_dias_in.days)
jul_fin='{:.4f}'.format(dif_dias_fin.days)


#Escribir el archivo limits
arch_limits=open("limits","w")
arch_limits.write(jul_in+' '+jul_fin)
arch_limits.close()


