#!/bin/bash

cp files/zoom.zip /home/pi/
cd /home/pi/
unzip /home/pi/zoom.zip
cp /home/pi/zoom/zoom.desktop /home/pi/Desktop/
chmod +x /home/pi/zoom/*
chmod +x /home/pi/Desktop/zoom.desktop
