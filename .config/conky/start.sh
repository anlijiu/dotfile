#!/bin/bash

sleep 2
conky -b -c /home/an/.config/conky/conky.conf -d 
conky -b -c /home/an/.config/conky/simple_calendar/simple_calendar.conf -d
sleep 2
conky -b -c /home/an/.config/conky/conky.mail.conf -d
