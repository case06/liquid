#!/bin/bash

MYHOME=/home/pi/liquid/bms_10s

DATE=`/bin/date "+%d.%m.%Y %H:%M:%S"`

#Skalierung der Y-Achse auf ein festes Maß

RANGE="-l2900 -u3600 -r "
#RANGE2="-l-2000 -u36000 -r "
RANGE2="-l-2 -u36 -r "
#RANGE3="-l0 -u360 -r "
RANGE3="-l-30 -u360 -r "
#SRANGE="-l-20 -u40 -r "
#RULCOL="00FFFF"
RULCOL="6622FF"

# HRULE:0#$RULCOL \
# LINE:0#$RULCOL:"...":dashes=15,5,5,10 \
# HRULE:0#$RULCOL:dashes=2,4 \
# LINE:0#$RULCOL:"":dashes=4,4 \


array=( 1 2 3 4 5 6 )
# Alle Elemente im Array durchlaufen
for value in ${array[*]}
do
   #echo $value

   case "$value" in
     1)	W=800
	H=400	 
	START=14400
	TITEL="4 Stunden"
	MODUS="LAST"
	INTERVALL="4h" ;;
     2)	W=800
	H=200	 
	START=129600
	TITEL=" 36 Stunden"
	MODUS="AVERAGE"
	INTERVALL="36h" ;;
     3)	W=800
	H=200	 
	START=604800
	TITEL="7 Tage"
	MODUS="AVERAGE"
	INTERVALL="7t" ;;
     4)	W=600
	H=100	 
	START=2592000
	TITEL="4 Wochen"
	MODUS="AVERAGE"
	INTERVALL="4w" ;;
     5)	W=600
	H=100	 
	START=31536000
	TITEL="12 Monate"
	MODUS="AVERAGE"
	INTERVALL="12m" ;;
     6)	W=600
	H=100	 
	START=580608000
	TITEL="20 Jahre"
	MODUS="AVERAGE"
	INTERVALL="20j" ;;
   esac
   #echo "$W $H $START $INTERVALL"


# Erzeuge Balancer Diagramme
nice -n 19 /usr/bin/rrdtool graph $MYHOME/rrdtool/sbms$INTERVALL\_balance.png \
--start -$START -a PNG $RANGE -t "$TITEL           Stand: $DATE" --vertical-label "mV" -w $W -h $H \
-c BACK#000000 -c CANVAS#000000 -c FONT#FFFFFF -c GRID#00FFFF -c MGRID#00FFFF -c FRAME#00FFFF \
-c SHADEA#000000 -c SHADEB#000000 -c AXIS#FFFFFF -c ARROW#FFFFFF \
DEF:c0=$MYHOME/rrdtool/bms.rrd:c0:AVERAGE \
DEF:c1=$MYHOME/rrdtool/bms.rrd:c1:AVERAGE \
DEF:c2=$MYHOME/rrdtool/bms.rrd:c2:AVERAGE \
DEF:c3=$MYHOME/rrdtool/bms.rrd:c3:AVERAGE \
DEF:c4=$MYHOME/rrdtool/bms.rrd:c4:AVERAGE \
DEF:c5=$MYHOME/rrdtool/bms.rrd:c5:AVERAGE \
DEF:c6=$MYHOME/rrdtool/bms.rrd:c6:AVERAGE \
DEF:c7=$MYHOME/rrdtool/bms.rrd:c7:AVERAGE \
DEF:c8=$MYHOME/rrdtool/bms.rrd:c8:AVERAGE \
DEF:c9=$MYHOME/rrdtool/bms.rrd:c9:AVERAGE \
LINE:3000#$RULCOL \
LINE:3500#$RULCOL \
LINE1:c0#ff0000:"CELL1" VDEF:c0a=c0,AVERAGE GPRINT:c0a:"%5.0lf" \
LINE1:c1#fa8258:"CELL2" VDEF:c1a=c1,AVERAGE GPRINT:c1a:"%5.0lf" \
LINE1:c2#ff00ff:"CELL3" VDEF:c2a=c2,AVERAGE GPRINT:c2a:"%5.0lf" \
LINE1:c3#00ff00:"CELL4" VDEF:c3a=c3,AVERAGE GPRINT:c3a:"%5.0lf" \
LINE1:c4#ffff00:"CELL5" VDEF:c4a=c4,AVERAGE GPRINT:c4a:"%5.0lf\n" \
LINE1:c5#58d3f7:"CELL6" VDEF:c5a=c5,AVERAGE GPRINT:c5a:"%5.0lf" \
LINE1:c6#8a4b08:"CELL7" VDEF:c6a=c6,AVERAGE GPRINT:c6a:"%5.0lf" \
LINE1:c7#939393:"CELL8" VDEF:c7a=c7,AVERAGE GPRINT:c7a:"%5.0lf" \
LINE1:c8#0000ff:"CELL9" VDEF:c8a=c8,AVERAGE GPRINT:c8a:"%5.0lf" \
LINE1:c9#298a08:"CELL10" VDEF:c9a=c9,AVERAGE GPRINT:c9a:"%5.0lf\n" \
 > /dev/null

# Erzeuge Charger Diagramme
nice -n 19 /usr/bin/rrdtool graph $MYHOME/rrdtool/sbms$INTERVALL\_charge.png \
--start -$START -a PNG $RANGE2 -t "$TITEL           Stand: $DATE" --vertical-label "V,A" -w $W -h $H \
-c BACK#000000 -c CANVAS#000000 -c FONT#FFFFFF -c GRID#00FFFF -c MGRID#00FFFF -c FRAME#00FFFF \
-c SHADEA#000000 -c SHADEB#000000 -c AXIS#FFFFFF -c ARROW#FFFFFF \
DEF:bat_volt=$MYHOME/rrdtool/bms.rrd:bat_volt:AVERAGE \
DEF:bat_amp=$MYHOME/rrdtool/bms.rrd:bat_amp:AVERAGE \
DEF:sol_amp=$MYHOME/rrdtool/bms.rrd:sol_amp:AVERAGE \
DEF:load_amp=$MYHOME/rrdtool/bms.rrd:load_amp:AVERAGE \
DEF:bat_soc=$MYHOME/rrdtool/bms.rrd:bat_soc:AVERAGE \
DEF:tmp1=$MYHOME/rrdtool/bms.rrd:tmp1:AVERAGE \
DEF:tmp2=$MYHOME/rrdtool/bms.rrd:tmp2:AVERAGE \
DEF:tmp3=$MYHOME/rrdtool/bms.rrd:tmp3:AVERAGE \
DEF:bat_dc=$MYHOME/rrdtool/bms.rrd:bat_dc:AVERAGE \
LINE:0#$RULCOL \
LINE1:bat_volt#6666ff:"BATVOLT" VDEF:bat_volta=bat_volt,AVERAGE GPRINT:bat_volta:"%5.2lf" \
LINE1:bat_amp#00dd00:"BATAMP" VDEF:bat_ampa=bat_amp,$MODUS GPRINT:bat_ampa:"%5.2lf" \
LINE1:sol_amp#dd00dd:"SOLAMP" VDEF:sol_ampa=sol_amp,AVERAGE GPRINT:sol_ampa:"%5.2lf" \
LINE1:load_amp#ddd000:"LOADAMP" VDEF:load_ampa=load_amp,AVERAGE GPRINT:load_ampa:"%5.2lf" \
LINE1:bat_dc#aaaaff:"BATDC" VDEF:bat_dca=bat_dc,AVERAGE GPRINT:bat_dca:"%5.2lf\n" \
 > /dev/null

# Erzeuge Ertrags Diagramme
nice -n 19 /usr/bin/rrdtool graph $MYHOME/rrdtool/sbms$INTERVALL\_yield.png \
--start -$START -a PNG $RANGE3 -t "$TITEL           Stand: $DATE" --vertical-label "W" -w $W -h $H \
-c BACK#000000 -c CANVAS#000000 -c FONT#FFFFFF -c GRID#00FFFF -c MGRID#00FFFF -c FRAME#00FFFF \
-c SHADEA#000000 -c SHADEB#000000 -c AXIS#FFFFFF -c ARROW#FFFFFF \
DEF:bat_soc=$MYHOME/rrdtool/bms.rrd:bat_soc:AVERAGE \
DEF:bat_watt=$MYHOME/rrdtool/bms.rrd:bat_watt:AVERAGE \
DEF:sol_watt=$MYHOME/rrdtool/bms.rrd:sol_watt:AVERAGE \
DEF:load_watt=$MYHOME/rrdtool/bms.rrd:load_watt:AVERAGE \
LINE:0#$RULCOL \
LINE1:bat_watt#00dd00:"BATWATT" VDEF:bat_watta=bat_watt,AVERAGE GPRINT:bat_watta:"%5.2lf" \
LINE1:sol_watt#dd00dd:"SOLWATT" VDEF:sol_watta=sol_watt,AVERAGE GPRINT:sol_watta:"%5.2lf" \
LINE1:load_watt#ddd000:"LOADWATT" VDEF:load_watta=load_watt,AVERAGE GPRINT:load_watta:"%5.2lf" \
 > /dev/null

done


# Einzelne Diagramme


W=200
H=100	 
START=129600
TITEL=" 36 Stunden"
MODUS="AVERAGE"
INTERVALL="36h"

# Erzeuge Temperatur Diagramm
RANGE4="-l0 -u60 -r "
nice -n 19 /usr/bin/rrdtool graph $MYHOME/rrdtool/sbms$INTERVALL\_temp.png \
--start -$START -a PNG $RANGE4 -t "$INTERVALL h : $DATE" --vertical-label "°C" -w $W -h $H \
-c BACK#000000 -c CANVAS#000000 -c FONT#FFFFFF -c GRID#00FFFF -c MGRID#00FFFF -c FRAME#00FFFF \
-c SHADEA#000000 -c SHADEB#000000 -c AXIS#FFFFFF -c ARROW#FFFFFF \
DEF:tmp1=$MYHOME/rrdtool/bms.rrd:tmp1:AVERAGE \
DEF:tmp2=$MYHOME/rrdtool/bms.rrd:tmp2:AVERAGE \
DEF:tmp3=$MYHOME/rrdtool/bms.rrd:tmp3:AVERAGE \
LINE:0#$RULCOL \
LINE1:tmp1#ddd000:"TEMP1" VDEF:tmp1a=tmp1,AVERAGE GPRINT:tmp1a:"%5.2lf\n" \
LINE1:tmp2#dd00dd:"TEMP2" VDEF:tmp2a=tmp2,AVERAGE GPRINT:tmp2a:"%5.2lf\n" \
LINE1:tmp3#00dd00:"TEMP3" VDEF:tmp3a=tmp3,AVERAGE GPRINT:tmp3a:"%5.2lf\n" \
 > /dev/null



# Erzeuge SOC Diagramm
RANGE5="-l0 -u300 -r "
nice -n 19 /usr/bin/rrdtool graph $MYHOME/rrdtool/sbms$INTERVALL\_soc.png \
--start -$START -a PNG $RANGE5 -t "$INTERVALL h : $DATE" --vertical-label "%" -w $W -h $H \
-c BACK#000000 -c CANVAS#000000 -c FONT#FFFFFF -c GRID#00FFFF -c MGRID#00FFFF -c FRAME#00FFFF \
-c SHADEA#000000 -c SHADEB#000000 -c AXIS#FFFFFF -c ARROW#FFFFFF \
DEF:bat_soc=$MYHOME/rrdtool/bms.rrd:bat_soc:AVERAGE \
LINE:0#$RULCOL \
LINE1:bat_soc#ddd000:"SOC" VDEF:bat_soca=bat_soc,AVERAGE GPRINT:bat_soca:"%5.2lf\n" \
 > /dev/null


