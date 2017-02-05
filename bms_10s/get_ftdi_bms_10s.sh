#!/bin/sh

# Vorher in separater Shell starten: MiniTerm (in Python)
#
# Aufruf:
# python -m serial.tools.miniterm -p /dev/ttyUSB1 -b 2400 -q > sbms.log
# beenden mit CTRL und ] (= eckige_Klammer_schliessend)
# mehr infos dazu unter http://pyserial.sourceforge.net/shortintro.html
# oder
# miniterm.py /dev/ttyACM0 115200 > bms_10s.log
# oder
# cu -l /dev/ttyACM0 -s 115200 > bms_10s.log
# oder
# cat /dev/ttyS0 > bms_10s.log &
#
# beenden mit kill Befehl aus benachbarter Shell


MYHOME=/home/pi/liquid/bms_10s
cd $MYHOME

# besorge Anzahl aktiver Sensoren
# wget http://192.168.178.7/index.html


# Check auf Vollständigkeit
COUNT=24
DUM=0
while [ $DUM -lt $COUNT ] 
do

  ZEILE=`tail -1 bms_10s.log`
  #echo $ZEILE
  DUM=`echo $ZEILE | tr -cd '|' | wc -c`
  #echo $DUM
done



CELL0=`echo $ZEILE | cut -d '|' -f 2`
CELL1=`echo $ZEILE | cut -d '|' -f 3`
CELL2=`echo $ZEILE | cut -d '|' -f 4`
CELL3=`echo $ZEILE | cut -d '|' -f 5`
CELL4=`echo $ZEILE | cut -d '|' -f 6`
CELL5=`echo $ZEILE | cut -d '|' -f 7`
CELL6=`echo $ZEILE | cut -d '|' -f 8`
CELL7=`echo $ZEILE | cut -d '|' -f 9`
CELL8=`echo $ZEILE | cut -d '|' -f 10`
CELL9=`echo $ZEILE | cut -d '|' -f 11`
CELL10=`echo $ZEILE | cut -d '|' -f 12`
CELL11=`echo $ZEILE | cut -d '|' -f 13`
CELL12=`echo $ZEILE | cut -d '|' -f 14`
CELL13=`echo $ZEILE | cut -d '|' -f 15`
CELL14=`echo $ZEILE | cut -d '|' -f 16`


BAT_VOLT=`echo $ZEILE | cut -d '|' -f 17`
BAT_AMP=`echo $ZEILE | cut -d '|' -f 18`
SOL_AMP=`echo $ZEILE | cut -d '|' -f 19`
LOAD_AMP=`echo $ZEILE | cut -d '|' -f 20`

BAT_SOC=`echo $ZEILE | cut -d '|' -f 21`
TMP1=`echo $ZEILE | cut -d '|' -f 22`
TMP2=`echo $ZEILE | cut -d '|' -f 23`
TMP3=`echo $ZEILE | cut -d '|' -f 24`
BAT_DC=`echo $ZEILE | cut -d '|' -f 25`

#echo "$CELL0 $CELL1 $CELL2 $CELL3 $CELL4 $CELL5 $CELL6 $CELL7 $CELL8 $CELL9 $CELL10 $CELL11 $CELL12 $CELL13 $CELL14 $BAT_VOLT $BAT_AMP $SOL_AMP $LOAD_AMP $BAT_SOC $TMP1 $TMP2 $TMP3 $BAT_DC"

#testvalue
# SOL_AMP=10000

LOAD_AMP=`expr $SOL_AMP - $BAT_AMP`

# Berechnung der Leistung
BAT_WATT=`expr $BAT_AMP \* $BAT_VOLT`
SOL_WATT=`expr $SOL_AMP \* $BAT_VOLT`
LOAD_WATT=`expr $LOAD_AMP \* $BAT_VOLT`


# Umrechnung von MilliVolt in Volt
BAT_VOLT=$(echo "scale=3; $BAT_VOLT/1000" | bc -l)
BAT_AMP=$(echo "scale=3; $BAT_AMP/1000" | bc -l)
SOL_AMP=$(echo "scale=3; $SOL_AMP/1000" | bc -l)
LOAD_AMP=$(echo "scale=3; $LOAD_AMP/1000" | bc -l)
BAT_DC=$(echo "scale=3; $BAT_DC/1000" | bc -l)

BAT_WATT=$(echo "scale=3; $BAT_WATT/1000000" | bc -l)
SOL_WATT=$(echo "scale=3; $SOL_WATT/1000000" | bc -l)
LOAD_WATT=$(echo "scale=3; $LOAD_WATT/1000000" | bc -l)


#BAT_AMP=`expr $BAT_AMP / 1000`
#SOL_AMP=`expr $SOL_AMP \* 1000`
#BAT_VOLT=`expr $CELL0 + $CELL1 + $CELL2 + $CELL3 - 10000`

# zum Schluß kommen die Daten in die Datenbank
# N steht für das aktuelle Datum und Uhrzeit

/usr/bin/rrdtool update $MYHOME/rrdtool/bms.rrd N:$CELL0:$CELL1:$CELL2:$CELL3:$CELL4:$CELL5:$CELL6:$CELL7:$CELL8:$CELL9:$CELL10:$CELL11:$CELL12:$CELL13:$CELL14:$BAT_VOLT:$BAT_AMP:$SOL_AMP:$LOAD_AMP:$BAT_SOC:$TMP1:$TMP2:$TMP3:$BAT_DC:$BAT_WATT:$SOL_WATT:$LOAD_WATT

DATE=`/bin/date "+%d.%m.%Y %H:%M:%S"`
echo "$DATE $CELL0 $CELL1 $CELL2 $CELL3 $CELL4 $CELL5 $CELL6 $CELL7 $CELL8 $CELL9 $CELL10 $CELL11 $CELL12 $CELL13 $CELL14 $BAT_VOLT $BAT_AMP $SOL_AMP $LOAD_AMP $BAT_SOC $TMP1 $TMP2 $TMP3 $BAT_DC $BAT_WATT $SOL_WATT $LOAD_WATT" >> $MYHOME/test.log

#echo "$CELL0 $CELL1 $CELL2 $CELL3 $CELL4 $CELL5 $CELL6 $CELL7 $CELL8 $CELL9 $CELL10 $CELL11 $CELL12 $CELL13 $CELL14 $BAT_VOLT $BAT_AMP $SOL_AMP $LOAD_AMP $BAT_SOC $TMP1 $TMP2 $TMP3 $BAT_DC $BAT_WATT $SOL_WATT $LOAD_WATT"

