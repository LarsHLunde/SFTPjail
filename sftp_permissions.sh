#!/bin/bash

# All of these scripts assume you run them as root
# or by using sudo, and will have to be chmod+x'ed

# MIT licensed
# Copyright Lars H. Lunde 2021

chown root:root /sftp
chown root:root /sftp/*
chmod 700 /sftp
chmod 700 /sftp/*

for i in $(ls /sftp); do
        chown root:$username -R sftp/$i/*
        chmod g+r -R /sftp/$i/*
done
