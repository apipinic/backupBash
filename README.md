# ABOUT

backup.sh - This script creates a signed and encrypted backup archive of a /home/<user> directory

restore_backup.sh - This script 

# CERTIFICATES

(1) Create folder with right permissions for certificates
sudo mkdir /home/cert
sudo chmod -R a+rwx cert/ 

(2) Create CA certificate
openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem

(3) Create server certificate, remove passphrase, and sign it
 openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem
 openssl rsa -in server-key.pem -out server-key.pem
 openssl x509 -req -in server-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# USAGE - Backup

(1) bash /home/backup.sh - to create a backup
  
(2) You will be asked for a home directory to be backuped, default folder is the logged in user e.g ubuntu
  
(3) Specify the keyfile you want to use for encryption e.g server-cert.pem
  
(4) A signed and encrypted backup is created under /tmp/ - for more backups press "yes"

# USAGE - Restore

(1) bash /home/restore_backup.sh - to restore a backup
  
(2) You will get a list of backupes to restore, use als input the whole output folder+filename e.g /tmp/ubuntu_backup-2022-05-23_15-58-31.tar.gz.enc
  
(3) Specify SSL certificate for verification purposes
  
(4) Secify the keyfile you want to use for decryption
  
(5) Congratulations, you successfully restored the backup!

# TEAM

Antonio Pipinic
20-05-2022, FH CAMPUS WIEN
