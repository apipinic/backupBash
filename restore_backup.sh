#########################################
##created by Antonio Pipinic 07.05.2022##
#########################################

#!/bin/bash

SSLCERT='/home/cert/server-cert.pem.pub'
searchDir=/tmp
echo "Following backups were found:"
for entry in "$searchDir"/*backup*enc
do
  echo "$entry"
done

read -p "Which backup do you want to restore? " fileToRestore

sudo openssl dgst -sha512 -verify ${SSLCERT} -signature ${fileToRestore}.sha512 ${fileToRestore}

sudo openssl smime -decrypt -in  ${fileToRestore} -binary -inform DEM -inkey /home/cert/server-key.pem -out ${fileToRestore%????}

echo "Backup successfull restored!"

echo "------------------------------------"

gunzip -c ${fileToRestore%????} | tar -tvf -
