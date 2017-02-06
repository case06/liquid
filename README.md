# liquid


Liquid is a server-frontend for visualizing logging-data from external sources, like sensory samples, logfiles, events and other kind of timelines.  Therefore it makes heavy use of the ringbuffer-database "rrdtool" (see http://oss.oetiker.ch/rrdtool/) as core database to store the data in an efficient and resource-saving manner. The ringbuffer-topology enables liquid to be used as a kind of live-monitoring system for processes with a certain inertia, like temperatur sensors or battery-cell monitoring. This gives you an overall graphical survey about the states of these processes.


![Titlescreen](https://raw.githubusercontent.com/case06/liquid/master/screenshots/bms_10s_main.png)


The liquid-application itself consists mainly of a few shell-scripts, which care for fullfilling two tasks:

- feeding the database with incoming sensory data

- generating diagramms from the recent database content

Of course the input can be filtered, extended or else modified befor feeding it into the db.


Liquid is thought and optimized for running on a Raspberry Pi as server, but it can probably become easily deployed on any kind of unix os, preferable a Debian-like distribution, e.g.  Ubuntu, Debian, Raspian (which acts here as reference). We consider the Raspberry Pi platform as best suited, especially because of its low energy consumption, but you can run liquid on any other kind of server or even at your desktop-pc.


The basic structure of a liquid application consists of a liquid directory within your home, eg "/home/pi/liquid", in which one or more independent (from each other) liquid monitors can be hosted, e.g. "home/pi/liquid/bms_10s".  The point is, that one liquid server can be host for a whole number of several monitoring applications, thats the reason why it is designed modular and running preferably on its own separate server. All these monitors can then be accessed from everywhere on the local network, or even from the internet, what makes it IoT-enabled ;) and of course it can receive data from remote sensors anywhere on the network, acting as an IoT-Host.

The application directory (here: "bms_10s") can be named arbitrary and contains alls the logfiles and the mentioned shell-scripts, of which some become frequently triggered by /etc/crontab. It contains furthermore a directory named "rrdtool", which contains the rrdtool-database, the generated diagram-pics and some html-files, which can be used locally or in an appropriate webspace, like /var/www/html, accessed through a webserver-daemon like apache or lightttpd.


For more detailed installation info see ![doc/install.txt](https://github.com/case06/liquid/blob/master/doc/install.txt)


Within this repository, we have the "bms_10s" which can be seen as an example application, but from our point of view it is a purpose on its own, to provide a nice monitoring application to the LibreSolar BMS projekt, see http://libre.solar.  So, others may follow later, but all examples in the liquid-docs and -configurations are related to the "bms_10s" monitor.


