#!/bin/bash



#Variables 

UUID=`uuidgen|cut -f 4 -d '-'`
OCIPROJECT="devops-prj-${UUID}"
read -e -i "$OCIPROJECT" -p "Enter Project Name " input
OCIPROJECT="${input:-$OCIPROJECT}"
echo "${OCIPROJECT}"
