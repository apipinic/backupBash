#########################################
##created by Antonio Pipinic 07.05.2022##
#########################################

#!/bin/bash

#sslCERT=server-cert.pem.pub
#keyFile=server-key.pem
searchDir=/tmp
echo "Following backups were found:"
for entry in "$searchDir"/*backup*enc
do
  echo "$entry"
done

read -p "Which backup do you want to restore? " fileToRestore
read -p "Please specify SSL certificate for verification purposes: " sslCERT
read -p "Please specify the keyfile you want to use for decryption: " keyFile

if sudo openssl dgst -sha512 -verify /home/cert/${sslCERT} -signature ${fileToRestore}.sha512 ${fileToRestore}
then
        sudo openssl smime -decrypt -in  ${fileToRestore} -binary -inform DEM -inkey /home/cert/${keyFile} -out ${fileToRestore%????}
        tar xfv ${fileToRestore%????} > /dev/null 2>&1
        echo "Backup successfull restored!"
        echo "------------------------------------"
        gunzip -c ${fileToRestore%????} | tar -tvf -
else
        echo "Backup not successfull restored."
        echo "Verification bad"
fi
