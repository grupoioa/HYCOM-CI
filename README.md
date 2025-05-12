## Repositorio de Hycom Team (2025) para Condiciones iniciales de Pronóstico HYCOM-IOA
- [Hycom Team](https://github.com/orgs/grupoioa/teams/hycom-team)

## Documentación

### Scripts de preprocesamiento y preparación de fechas.
  1. Script de preprocesamiento: Forzamientos atmosféricos (WRF), archivo limits (fecha en dias julianos), etc.

#### base\_preprocesa.sh

Este script crea las condiciones iniciales necesarias para la ejecución del pronostico HYCOM - 2025 (Se utiliza Climatologia HYCOM-IOA)

1. Crea forzamientos
2. Crea archivo limits con la fecha en dias julianos 

#### dias\_jul.py

Conversión de fecha de ejecución a julianos con fecha de referencia 31/12/1900.

##### Parámetros
1. fecha de inicio de simulación
2. fecha de fin de simulación

##### Salidas

Almacena las fechas ingresadas como parámetros en el archivo "limits" (en juliano)
