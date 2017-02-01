#!/bin/bash
# Linux/UNIX box with ssh key based login enabled
# Systems
# Replace values in {brackets} with your own values and remove brackets.
# This script is intended to be used as a wrapper for a simple command to show ACLs from ONTAP storage.
CLUS="{IP address or hostname}"
# SSH User names
ADMIN="{admin or other user}"
# SVM Names
SVM1="{SVM name}"
OBJPATH=$1
echo "Do you want to expand the ACL masks to show all fields? (enter 1 or 2)"
echo CAUTION: Output may be lengthy
echo
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ssh $ADMIN@$CLUS "set diag; vserver security file-directory show -vserver $SVM1 -path $OBJPATH -expand-mask true -lookup-names true"; break;;
        No ) ssh $ADMIN@$CLUS "set diag; vserver security file-directory show -vserver $SVM1 -path $OBJPATH" ; break;;
    esac
done
