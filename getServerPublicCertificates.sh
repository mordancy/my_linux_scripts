#!/bin/bash

#this script will pull the certs from the urls for payment center (used between the F5 and ESPM)
#you can run this in your cygwin terminal or you can run the command on the hub server
#
#echo -n releases the connection from the server
#openssl s_client is used to set up a client ssl/tls connection to a server
#the connect parameter uses the server and port for the connection
#the sed command grabs the oputput between and including the lines that contain begin certificate and end certificate
#output the cert to a file

#TODO add array list for domains to check
#TODO add menu
#TODO add menu option for manual input or loop through the array list


#set directory to store the public certificates
DIRECTORY="~/tmp/certs"
pwd
echo "DIRECTORY = ${DIRECTORY}"

#create the directory if it does not exist
#if [ ! -d "$DIRECTORY" ]; then
#  mkdir -p ${DIRECTORY}
#  echo "creating new folder structure: <$DIRECTORY>"
#fi
#
#cd ${DIRECTORY}

pwd

echo -n | openssl s_client -connect myDomain.com:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/tmp/certs/myDomain.cer


#view the certificates and the dates which the certificates are valid for all certs in a folder
for i in $(\ls ~/tmp/certs/*.cer);
    do 
       echo;
       echo cert information for: $i;
       openssl x509 -text -inform PEM -in ${i} | sed -ne '/Not\ Before/,/Not\ After/p'; 
       echo;
    done
