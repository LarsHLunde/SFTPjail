#!/bin/bash

# All of these scripts assume you run them as root
# or by using sudo, and will have to be chmod+x'ed

# MIT licensed
# Copyright Lars H. Lunde 2021

echo "Which user would you like to give an upload folder to"

read username

mkdir -p /sftp/$username/upload
chown root:$username /sftp/$username/upload
chmod 770 /sftp/$username/upload
