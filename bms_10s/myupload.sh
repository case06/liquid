#!/bin/sh
cd /home/pi/liquid/bms_10s/rrdtool
HOST='your_public_wegpage'
USER='your_username'
PASSWD='your_passwd'
FILE='sampledata.1'

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd html
cd blog
cd transfer
put sbms4h_balance.png
put sbms36h_balance.png
put sbms7t_balance.png
put sbms4w_balance.png
put sbms12m_balance.png
put sbms20j_balance.png
put sbms4h_charge.png
put sbms36h_charge.png
put sbms7t_charge.png
put sbms4w_charge.png
put sbms12m_charge.png
put sbms20j_charge.png
put sbms4h_yield.png
put sbms36h_yield.png
put sbms7t_yield.png
put sbms4w_yield.png
put sbms12m_yield.png
put sbms20j_yield.png
put sbms36h_soc.png
put sbms36h_temp.png
put kwh_yield.svg
put power.svg
put temp.svg
quit
END_SCRIPT
exit 0


