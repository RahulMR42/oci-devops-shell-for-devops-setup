#!/bin/bash



#Variables 

UUID=`uuidgen|cut -f 4 -d '-'`
OCIPROJECT="devopsprj-${UUID}"

echo "Here is the available compartments"

oci iam compartment  list --query "data[*].{Name:name,ID:id}" --output table

read -p "OCI Compartment OCID ?:" compartmentid

echo "Here are the available OCI notification topics"

oci ons topic list --compartment-id ${compartmentid} --all --output table --query "data[*].{Name:name,ID:id}"

read -p "Devops Project Name ? [${OCIPROJECT}]: " prjname
prjname=${prjname:-${OCIPROJECT}}
echo $prjname