#!/bin/bash
# Linux/UNIX box with ssh key based login enabled
# Systems
# Replace values in {brackets} with your own values and remove brackets.
CLUS="{IP address or hostname}"
# SSH User names
ADMIN="{admin or other user}"
# SVM Names
SVM1="{SVM name}"
echo
echo
echo =====================================================================
echo  Check the permissions of a volume, qtree, folder or file in ONTAP
echo =====================================================================
echo
echo Please enter the complete path of your volume, qtree, folder or file in ONTAP.
echo Example: /volname/qtree/file.txt
echo
read OBJPATH
echo "Do you want to expand the ACL masks to show all fields? (enter 1 or 2)"
echo CAUTION: Output may be lengthy
echo
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ssh $ADMIN@$CLUS "set diag; vserver security file-directory show -vserver $SVM1 -path $OBJPATH -expand-mask true -lookup-names true"; break;;
        No ) ssh $ADMIN@$CLUS "set diag; vserver security file-directory show -vserver $SVM1 -path $OBJPATH" ; break;;
    esac
done
echo
