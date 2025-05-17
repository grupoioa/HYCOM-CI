'''
Genera archivo .limits y variabless fecha_ini y fecha_fin

Parámetros:
   - fecha de inicio
   - duración de simulación en horas

fecha de referencia 31/12/1900 (HYCOM)
'''

import datetime as dt
import sys

# crea fechas
date_fmt = '%Y-%m-%d_%H'
inicio = dt.datetime.strptime(sys.argv[1], date_fmt )
final = inicio + dt.timedelta(hours = int(sys.argv[2]))

#Calcular las diferencias en dias
ref = dt.datetime(1900,12,31)
inicio_ref = inicio - ref
fin_ref = final - ref

# almacena en archivo .limits
str_ini='{:.4f}'.format(inicio_ref/ dt.timedelta(days=1))
str_fin='{:.4f}'.format(fin_ref/ dt.timedelta(days=1))
filename = inicio.strftime( '000y0%y0%j0%H.limits' )

with open(filename, "w") as file_lim:
    file_lim.write(str_ini +' '+ str_fin )

# crea .env con variables de fechas
with open('.env', 'w') as pfile:
    print('fecha_ini="' + sys.argv[1]+ '"', file= pfile)
    print('fecha_fin="' + final.strftime( date_fmt ) + '"', file = pfile )

