#!/bin/csh
#
set echo
set time=1
#
# --- form interpolated subregion archive files, GLB0.08 to GOMl0.04.
#
# --- script includes logic to reduce the number of layers,
# --- but it is inactivated here by setting L to "".
#
# --- ALL/bin/hycom_ij2lonlat can be used to find co-located points
# ---  on the two grids.  Since subregion p(1,1) must be on the
# ---  original grid, this is usually the point to reference.
# ---   USE: hycom_ij2lonlat 1 1 regional.grid.a
#
#ruta datos ab originales
setenv D /LUSTRE/OPERATIVO/OPERATIVO2/entradas/HYCOM/recorte_glb_pron 
#ruta topo original
setenv DT ${D}/topo
#ruta salidas resultantes
setenv R  /LUSTRE/OPERATIVO/OPERATIVO2/modelos/HYCOM/nest
setenv RT ${R}/../topo
setenv E  101
setenv Y  100
#setenv A  hi
#
# --- single model segment, potentially across two calendar years.
# --- configured for  30-day surface and  30-day 3-d archives.
#
setenv YRFLAG  0
setenv BNSTFQ  1.0
setenv NESTFQ  1.0

#foreach A ( a ab b bc c cd d de e ef f fg g gh h hi i ij j jk k kl l la )
foreach A ( a )

## Original Grid 
    touch   regional.grid.a
    /bin/rm regional.grid.[ab]
    /bin/ln -s ${DT}/regional.grid.a regional.grid.a
    /bin/ln -s ${DT}/regional.grid.b regional.grid.b
#

    ## Results files
    touch   ${R}/archv.100-103_${A}.b
    /bin/rm ${R}/archv.100-103_${A}.[ab]
/LUSTRE/OPERATIVO/OPERATIVO2/OPERATIVO_HYCOM/HYCOM-tools/subregion/src/isubregion <<E-o-D
${D}/US058GCOM-OPSnce.espc-d-031-hycom_fcst_glby008_2025051812_M0000_archm.a
${DT}/depth_GLBy0.08_27.b
${R}/archv.100-103_${A}_L41.b 
${RT}/regional.depth.b
GLBb0.08 interpolated to GOMl0.04
  541	  'idm   ' = longitudinal array size
  385	  'jdm   ' = latitudinal  array size
  2349	  'irefi ' = longitudinal input  reference location
  1735	  'jrefi ' = latitudinal  input  reference location
  1	  'irefo ' = longitudinal output reference location
  1	  'jrefo ' = latitudinal  output reference location
  2	  'ijgrd ' = integer scale factor between input and output grids
  1       'iceflg' = ice in output archive flag (0=none,1=energy loan model)
  1       'smooth' = smooth interface depths    (0=F,1=T)
E-o-D

#touch   ${R}/archv.100-103_${A}_L41.b

E-o-D

end
 US058GCOM-OPSnce.espc-d-031-hycom_fcst_glby008_2025051812_M0000_archm.a
