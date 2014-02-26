#!/bin/bash
#this will set a value to keep your ssh sessions from disconnecting
cat > ~/.ssh/config << EOF
Host *
 ServerAliveInterval 60
EOF
