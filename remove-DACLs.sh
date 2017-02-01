#!/bin/bash
# Linux/UNIX box with ssh key based login enabled
# Systems
# Replace values in {brackets} with your own values and remove brackets.
# This script is intended to be used to clean up any DACLs or policies created. This does not have to be run if you intend on keeping the existing entries around.
CLUS="{IP address or hostname}"
# SSH User names
ADMIN="{admin or other user}"
# SVM Names
SVM1="{SVM name}"
POL="{policy name}"
## Clean up policy, DACL, etc.
ssh $ADMIN@$CLUS "set diag; vserver security file-directory policy task remove -vserver $SVM1 -policy-name $POL *"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs dacl remove -vserver $SVM1 *"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs delete -vserver $SVM1 *"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory policy  delete -vserver $SVM1 -policy-name $POL"
