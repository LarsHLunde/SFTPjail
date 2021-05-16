#!/bin/bash

# All of these scripts assume you run them as root
# or by using sudo, and will have to be chmod+x'ed

# MIT licensed
# Copyright Lars H. Lunde

echo "Please enter the name of the new sftp user"
read username

mkdir -p /sftp/$username
useradd -m -s /sbin/nologin -d /sftp/$username $username
usermod -a -G sftpusers $username
chown root:root /sftp
chown root:root /sftp/*
chmod 700 /sftp
chmod 700 /sftp/*

chown root:$username -R sftp/$username/*
chmod g+r -R /sftp/$username/*

echo "Please set password for new user"
passwd $username
