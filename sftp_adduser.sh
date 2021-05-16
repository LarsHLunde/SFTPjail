#!/bin/bash

# All of these scripts assume you run them as root
# or by using sudo, and will have to be chmod+x'ed

# MIT licensed
# Copyright Lars H. Lunde 2021

echo "Please enter the name of the new sftp user"
read username

mkdir -p /sftp/$username
useradd -m -s /sbin/nologin -d /sftp/$username $username
usermod -a -G sftpusers $username
chown root:root /sftp
chown root:$username /sftp/*
chmod 700 /sftp
chmod 750 /sftp/*

echo "Please set password for new user"
passwd $username
