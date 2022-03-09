#!/bin/bash
#Shell script covering OCI CLIs for devops project.

##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
        echo -ne $green$1$clear
}
ColorBlue(){
        echo -ne $blue$1$clear
}

list_projects(){
    compartmentid=$1
    oci devops project list --compartment-id $compartmentid --all --query 'data.items' --output table

}

create_project(){
    compartmentid=$1
    echo "Here are the available OCI notification topics"
    oci ons topic list --compartment-id ${compartmentid} --all --output table --query 'data[*].{Name:name,TopicID:"topic-id"}'
    read -p "OCI Notification TopicID ?:" onstopicid
    read -p "Devops Project Name ? : " prjname
    oci devops project create --compartment-id ${compartmentid} --name ${prjname} --notification-config '{"topicId":"'${onstopicid}'"}' --description "Project ${prjname}" --output table 

}

oci_prj_menu(){

    echo "Here is the available compartments"
    oci iam compartment  list --query "data[*].{Name:name,ID:id}" --output table
    read -p "OCI Compartment OCID ?:" compartmentid
    OCI Devops Project menu - ${compartmentid}    
    echo -ne "
    OCI Devops PROJECT menu - Compartment ID : $1
    $(ColorGreen '1)') List projects.
    $(ColorGreen '2)') Create project.
    $(ColorGreen '100)') Back to main.
    $(ColorGreen '0)') exit.
    $(ColorBlue 'Choose an option:') "
            read choice
            case $choice in
                1) list_projects $compartmentid ; oci_prj_menu ;;
                2) create_project $compartmentid;  oci_prj_menu;;
                100) main_menu ;;
            0) exit 0 ;;
            *) echo -e "Invalid"
            esac

}

oci_build_menu(){

    echo "Here is the available compartments"
    oci iam compartment  list --query "data[*].{Name:name,ID:id}" --output table
    read -p "OCI Compartment OCID ?:" compartmentid
    OCI Devops Build menu - ${compartmentid}    
    echo -ne "
    OCI Devops PROJECT menu - Compartment ID : $1
    $(ColorGreen '1)') List build pipelines.
    $(ColorGreen '2)') Create build pipelines.
    $(ColorGreen '100)') Back to main.
    $(ColorGreen '0)') exit.
    $(ColorBlue 'Choose an option:') "
            read choice
            case $choice in
                1) list_buildpipelines $compartmentid ; oci_prj_menu ;;
                2) create_project $compartmentid;  oci_prj_menu;;
                100) main_menu ;;
            0) exit 0 ;;
            *) echo -e "Invalid"
            esac

}

main_menu(){


echo -ne "
OCI Devops Quick menu 
$(ColorGreen '1)') devops project
$(ColorGreen '2)') build pipeline
$(ColorGreen '3)') deploy pipeline
$(ColorGreen '4)') policies & dynamic groups
$(ColorGreen '5)') A CICD pipeline
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read choice
        case $choice in
                1) oci_prj_menu ; main_menu ;;
                2) oci_build_menu ; main_menu ;;
                3) oci_deploy ; main_menu ;;
                4) oci_policies ; main_menu ;;
                5) all_checks ; main_menu ;;
                0) exit 0 ;;
                *) echo -e "Invalid"
        esac
}

main_menu