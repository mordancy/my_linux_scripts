#!/usr/bin/bash


QUIT=0
#If your userid is not a local variable add it here 
#or use the menu option to change the value 
#USERID=


#####################################################
# DISPLAY MENU FOR SSH OPTIONS                      #
#####################################################
display_menu(){
echo
echo "###########################################"    
echo "#                                         #"   
echo "#     Set up keys for remote servers      #"   
echo "#         for user ${USERID}                #"   
echo "#                                         #" 
echo "###########################################"
echo "C. Press U to create your local RSA key"
echo "D. Press D to load your rsa key to all remote development servers"
echo "Q. Press Q to load your rsa key to all remote qa servers"
echo "P. Press P to load your rsa key to all remote production servers"
echo "A. Press A to load your rsa key to all remote servers"
echo "S. Press S to load your rsa key to a specific remote servers"
echo "U. Press U to enter a different user id."
echo "Q. Press Q to quit."
}

#####################################################
#  THIS TAKES THE INPUT PROVIDED BY THE USER        #
#  AND EXECUTED THE APPROPRIATE OPTION USING CASE   #
#####################################################
menu_options(){
display_menu
echo "Please select option from the list above"
read OPTION
case $OPTION in
        [cC]) echo "Generating Local RSA key"
              generateLocalKey
           ;;
        [dD]) echo "Loading key for development servers"
              SERVERARRAY=(devapp01 devapp02 devdb01 devdb02)
              runserverlist
           ;;
        [qQ]) echo "Loading key for quality assurance servers"
              SERVERARRAY=(qaapp01 qaapp02 qadb01 qadb02)
              runserverlist
           ;;
        [pP]) echo "Loading key for production servers"
              SERVERARRAY=(prdapp01 prdapp02 prddb01 prddb02)
              runserverlist
           ;;
        [aA]) echo "Loading key for all servers"
              SERVERARRAY=(devapp01 devapp02 devdb01 devdb02 qaapp01 qaapp02 qadb01 qadb02 prdapp01 prdapp02 prddb01 prddb02)
              runserverlist
           ;;
        [sS]) echo "Enter the server name to load the rsa key to:"
              read SERVERARRAY
              echo "you entered ${SERVER}"
              runserverlist
           ;;
        [uU]) echo "Enter a new user id:"
              read USERID
              echo "you entered ${USERID}"
           ;;
        [qQ]) QUIT=1;;
        *) echo "Invalid selection. Please try again"
           ;;
    esac
}

#####################################################
#  GENERATE LOCAL RSA KEY IF IT DOESNT EXIST        #
#####################################################
generateLocalKey(){
if [ -f ~/.ssh/id_dsa.pub ]
  then
    echo ".ssh/id_dsa.pub already exists"
else
  echo ".ssh/id_dsa.pub does not exists ... running ssh-keygen"
  echo "Press enter for all three inputs"
  ssh-keygen -t dsa;
  chmod 600 .ssh/id_dsa
fi
}

#####################################################
#  THIS FUNCTION RUNS THE loadscp FUNCTION          #
#  FOR THE VALUE IN $SERVER                         #
#####################################################
loadscp(){
if [ -f .ssh/id_dsa.pub ]
  then
    echo "uploading .ssh/id_dsa.pub for <${USERID}> to server <${SERVER}>"
else
  generateLocalKey
fi

echo "checking for file .ssh/authorized_keys for user <${USERID}> on server <${SERVER}>"
if ssh $USERID@$SERVER test -e .ssh/authorized_keys
  then
    echo "file .ssh/authorized_keys already exists"
  else
    echo "RUNNING loadscp function for user <${USERID}> on server <${SERVER}>"
    scp .ssh/id_dsa.pub $USERID@$SERVER:
    sshkeysetup
fi
}


#####################################################
#  THIS FUNCTION COPIES THE id_dsa.pub FILE TO      #
#  .ssh/authorized_keys FOR THE VALUE IN $SERVER    #
#####################################################
sshkeysetup(){
ssh $USERID@$SERVER 'bash -s'  <<EOF
if [ -d .ssh ]
then
echo "Directory found"
else 
echo "Directory not found ... creating directory .ssh"
mkdir .ssh
chmod 700 .ssh
fi

ls -la

if [ -f .ssh/authorized_keys ]; then
echo "file exists"
else
echo "authorized_keys file does not exist ... creating file"
cat id_dsa.pub >> .ssh/authorized_keys
fi
ls -al .ssh

sleep 5

chmod 700 .ssh
rm id_dsa.pub
pwd

sleep 5

ls -al
ls -al .ssh

sleep 5
exit

EOF
}


#####################################################
#  THIS FUNCTION RUNS THE loadscp FUNCTION          #
#  FOR EACH VALUE IN THE ARRAY $SERVERARRAY         #
#####################################################
runserverlist(){
for SERVER in ${SERVERARRAY[*]}
do
    echo "RUNNING loadscp for <${USERID}> to server <${SERVER}>"
    loadscp
done

}


#####################################################
#  DISPLAY MENU OPTIONS UNTIL Q IS SELECTED         #
#####################################################
while [ $QUIT -lt 1 ]
do
    menu_options
done
