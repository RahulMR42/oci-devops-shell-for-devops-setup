#!/bin/bash



#Variables 

uid=uuidgen|awk -F '-' '{print $(NF)}'
echo "Proceeding with a unique id ${uid}"
read -p "OCI Devops Project Name [devops-prj-${uid}]: " name
echo $name
