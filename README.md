# liquid




Liquid is a server-frontend for visualizing logging-data from external sources, like sensory samples, logfiles, events and other kind of timelines.  Therefore it makes heavy use of the ringbuffer-database "rrdtool" (see http://oss.oetiker.ch/rrdtool/) as core database to store the data in an efficient and resource-saving manner. The ringbuffer-topolgy enables liquid to be used as a kind of live-monitoring system for processes with a certain inertia, like temperatur sensors or battery-cell monitoring. This gives you an overall graphical survey about the states of these processes.


![Title]https://raw.githubusercontent.com/case06/liquid/master/screenshots/bms_10s_main.png


The liquid-application itself consists mainly of a few shell-scripts, which care for fulfilling two tasks:

- feeding the database with incoming sensory data

- generating diagramms from the recent database content

Of course the input can be filtered, extended or else modified befor feeding it into the db.


Liquid is thought and optimized for running on a Raspberry Pi as server, but it can probably become easily deployed on any kind of unix os, preferable a Debian-like distribution, e.g.  Ubuntu, Debian, Raspian (which acts here as reference). We consider the Raspberry Pi platform as best suited, especially because of its low energy consumption, but you can run liquid on any other kind of server or even at your desktop-pc.


The basic structure of a liquid application consists of a liquid directory within your home, eg "/home/pi/liquid", in which one or more independent (from each other) liquid monitors can be hosted, e.g. "home/pi/liquid/bms_10s".  The point is, that one liquid server can be host for a whole number of several monitoring applications, thats the reason why it is designed modular and running preferably on its own external server. All these monitors can then be accessed from everywhere on the loal network (or even the internet, what makes it IoT-enabled ;)).

The application directory can be named arbitrary and contains alls the logfiles and the mentioned shell-scripts, of which some become frequently triggered by /etc/crontab. There is furthermore a directory named "rrdtool", which contains the rrdtool-database, the generatetd diagram-pics and some html-files, which can be used locally or in an appropriate webspace, like /var/www/html, accessed through a webserver-daemons like apache or lightttpd.


For more detailed installation info see doc/install.txt









