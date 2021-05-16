#!/bin/bash

chown root:root /sftp
chown root:root /sftp/*
chmod 700 /sftp
chmod 700 /sftp/*

for i in $(ls /sftp); do
        chown root:$username -R sftp/$i/*
        chmod g+r -R /sftp/$i/*
done
