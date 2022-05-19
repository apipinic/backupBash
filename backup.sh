#########################################
##created by Antonio Pipinic 07.05.2022##
#########################################

#!/bin/bash

currentUser="$USER"
#of=backup-$(date +%Y-%m-%d_%H:%M:%S).tar.gz
defaultDir=/home/${currentUser}
tempDir=/tmp/
arrUser=()

read -p "Specify another home directory to be backuped (default is: /home/${USER}): " otherDir

#total number of files for a given directory
#The expression ‘^-‘ had been used to search for regular files
function nrFiles() {
        nfiles=$(ls -l $defaultDir | grep '^-' | wc -l)
        echo "Anzahl der files in "${defaultDir}": ${nfiles}"
}

#total number of directories for a given directory
function nrDirectories() {
        ndirs=$(find $defaultDir ! -path $defaultDir -type d | wc -l)
        echo "Anzahl der directories in "${defaultDir}": ${ndirs}"
}

function sanityCheck(){
        folderCount=$(find $defaultDir |wc -l)
        tarCount=$(gunzip -c ${tempDir}${currentUser}_${of} | tar -tvf -  |wc -l)

        if [ $folderCount == $tarCount ]
        then
                echo "Sanitycheck successfully"
        else
                echo "Sanitycheck not successfull"
        fi
}

function backupFile(){
        #of variable needs to be declared here because of date should be always higher after every loop
        of=backup-$(date +%Y-%m-%d_%H:%M:%S).tar.gz
        if sudo tar -czvf ${tempDir}${currentUser}_${of} -C /tmp/ $defaultDir > /dev/null 2>&1
        then
                echo "Backup was finished successfully in /tmp/: "${currentUser}_${of}
                counterFiles=$(ls -l $defaultDir | grep '^-' | wc -l)
                let counterFilesTemp=counterFiles+counterFilesTemp

                counterDir=$(find $defaultDir ! -path $defaultDir -type d | wc -l)
                let counterDirTemp=counterDir+counterDirTemp

                arrUser[${#arrUser[@]}]=$defaultDir

        fi
}
function newHomeDir(){
        if [ -z "$otherDir" ]
        then
                backupFile
        else
                newHomeDir=/home/${otherDir}
                defaultDir=$newHomeDir
                currentUser=$otherDir
                backupFile
        fi

}

function checkFolder(){
        if [ -d "/home/${otherDir}" ]
        then
                newHomeDir
                nrFiles
                nrDirectories
                sanityCheck
        else
                echo "Couldn't proceed with backup, no folder/user found!"
        fi
}

#Functions
checkFolder

while true;
do
    read -r -p "Do you want to do another backup? [yes/no]  " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        read -p "Specify another home directory to be backuped (default is: /home/${USER}): " otherDir
        if [ -z "$otherDir" ]
                then
                        defaultDir=/home/${USER}
                        currentUser=$USER
                        backupFile
                        nrFiles
                        nrDirectories
                        sanityCheck
                else
                        newHomeDir=/home/${otherDir}
                        defaultDir=$newHomeDir
                        currentUser=$otherDir
                        backupFile
                        nrFiles
                        nrDirectories
                        sanityCheck

                fi

        else
        unique_sorted_list=($(printf "%s\n" "${arrUser[@]}" | sort -u))

        #echo $unique_sorted_list

        for i in "${unique_sorted_list[@]}"
        do
                echo $i
        done

        echo "Totally files backuped: "${counterFilesTemp}
        echo "Totally directories backuped: "${counterDirTemp}
        echo "Totally users backuped: ${#unique_sorted_list[@]}"

        exit 0
    fi
done
