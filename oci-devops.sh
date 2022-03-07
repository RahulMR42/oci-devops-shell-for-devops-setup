#!/bin/bash



#Variables 

uniqid=uuidgen|awk -F '-' '{print $(NF)}'
echo "Proceeding with a unique id ${uniqid}"
read -p "OCI Devops Project Name [devops-prj-${uniqid}]: " name
echo $name
