# ABOUT

backup.sh - This script creates a signed and encrypted backup archive of a /home/<user> directory

restore_backup.sh - This script 

# USAGE

(1) build the application -> make BOARD=samr21-xpro

(2) flash the application -> make BOARD=samr21-xpro flash

# INFO: install moserial to display the result
# CONFIGURE MOSERIAL:
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


# TEAM
Antonio Pipinic
20-05-2022, FH CAMPUS WIEN
