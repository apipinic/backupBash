#ABOUT
This is an application measuring the temperature on a samr21-xpro board using a sensor.
The software is written in C with RIOT-OS(2022.07) as operating system.

#USAGE

(1) build the application -> make BOARD=samr21-xpro

(2) flash the application -> make BOARD=samr21-xpro flash

#INFO: install moserial to display the result
#CONFIGURE MOSERIAL:
	(1) start moserial
	(2) click on port setup
	(3) Device: /dev/ttyACM0
	    Baud Rate: 115200
	    Data Bits: 8
	    Stop Bits: 1
	    Parity: None
            Handshake: chekc Hardware and Software
	    Access Mode: Read and Write
            Local Echo: unchecked
	(4) click ok
	(5) click connect button
(3) output example: Temperature [C]: 26.31 


#TEAM
Fajic Ahmedin, Bajrica Armin, Fauland Robert
05-13-2022, FH CAMPUS WIEN
