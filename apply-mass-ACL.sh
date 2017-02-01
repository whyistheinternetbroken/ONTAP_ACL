#!/bin/bash
# Linux/UNIX box with ssh key based login enabled
# Systems
# Replace values in {brackets} with your own values and remove brackets.
CLUS="{IP address or hostname}"
# SSH User names
ADMIN="{admin or other user}"
# SVM Names
SVM1="{SVM name}"
# Path to re-acl
ACLPATH="{/path/to/re-acl}"
#######################################################
## Create policy
ssh $ADMIN@$CLUS "set diag; vserver security file-directory policy create -vserver $SVM1 -policy-name re-acl"
## Add Owner/Group
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs create -vserver $SVM1 -ntfs-sd sdname -owner prof1 -group profgroup"
## Add ACEs for ACL
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs dacl add -vserver $SVM1 -ntfs-sd sdname -access-type allow -account NTAP\administrator -rights full-control -apply-to this-folder,sub-folders,files"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs dacl add -vserver $SVM1 -ntfs-sd sdname -access-type allow -account NTAP\sharedgroup -rights read -apply-to this-folder,sub-folders,files"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory ntfs dacl add -vserver $SVM1 -ntfs-sd sdname -access-type allow -account NTAP\prof1 -rights write -apply-to this-folder,sub-folders,files"

## Remove SYSTEM accounts (which are added by default)
ssh $ADMIN@$CLUS "set diag; file-directory ntfs dacl remove -vserver $SVM1 -ntfs-sd sdname -access-type allow -account BUILTIN\*"
ssh $ADMIN@$CLUS "set diag; file-directory ntfs dacl remove -vserver $SVM1 -ntfs-sd sdname -access-type allow -account CREATOR*"
ssh $ADMIN@$CLUS "set diag; file-directory ntfs dacl remove -vserver $SVM1 -ntfs-sd sdname -access-type allow -account *SYSTEM"
## Create task and set path
ssh $ADMIN@$CLUS "set diag; vserver security file-directory policy task add -vserver $SVM1 -policy-name re-acl -path $ACLPATH -ntfs-sd sdname -ntfs-mode propagate -security-type ntfs"
ssh $ADMIN@$CLUS "set diag; vserver security file-directory apply -vserver $SVM1 -policy-name re-acl -ignore-broken-symlinks true"
