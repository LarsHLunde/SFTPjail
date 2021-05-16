# SFTP jail
An article and helper scripts for setting up chrooted SFTP accounts for safe use

## Preface
The goal of this little project of mine is to explain to the reader  
and my future self why setting up SFTP accounts with chroot is such a pain.

It also includes some helper scripts for myself and anyone less skilled  
at scripting than myself to work the system in a successful manner.

I will start the article by explaining how to use the scripts,  
what the scripts expect and some design choices.

The second part will be explaining all the pitfalls and  
mechanisms that makes this such a pain and explain some design choices.

## Using the scripts
All pieces of code are expected to be run as root or with sudo.
### Prerequisites
Before starting out there's a manual portion to configuring the server.  
The scripts expect to use **/sftp** for the homes of these SFTP users,  
it expects there to be an sftpusers group, and some manual configuration  
of the SSH daemon to acommodate the chroots.

First add a new group called sftpusers
```groupadd sftpusers```  
Then we need to edit **/etc/ssh/sshd_config** to force all users in  
the new group to take to the chroot jail and their homes in **/sftp**.  
So we create the **/sftp** folder and set the permission to root only.  
```
mkdir /sftp
chmod 700 /sftp
```

In **/etc/ssh/sshd_config**, usually towards the bottom there should  
be a line saying something like:  
```Subsystem       sftp    /usr/lib/openssh/sftp-server```   
Add a hash **(#)** in front of it and add this to it instead:  
```
#Subsystem      sftp    /usr/libexec/openssh/sftp-server
Subsystem       sftp    internal-sftp
``` 
Then add this passage to the end of the file
```
Match Group sftpusers
	ChrootDirectory /sftp/%u
	ForceCommand internal-sftp
```
for the changes to take effect, ssh server needs to be restarted:  
```service sshd restart```   

### The scripts
The first and by far most important scrip is the **sftp_adduser.sh**  
script as it sets up your user for you and does all the magic.
If you copy it in to a file and run ```bash sftp_adduser.sh```,  
you should be done and ready to rock.

A thing to not however is that by default your SFTP user has no  
way of writing to their home. This is by design and there is no  
way to both run chroot and be able to create a file in your home.  
At least not in the normal Linux SSHD, this will be discussed later.  
However that leads us neatly in to script number 2.

**sftp_upload.sh** adds an upload folder to any user you input  
as a subdirectory of their home directory, where they are free  
to upload whatever and how much ever they want to your server.  

If you want to limit the amount of data someone can put there,  
you will have to use an external mechanism, my suggestions would,  
be to use a mounted virtual disk or LVM if available.  

This should do the trick for the curious:  
https://www.tecmint.com/create-virtual-harddisk-volume-in-linux/

The third script will atempt to repair file permissions in your  
**/sftp** folder and subfolders, if it doesn't work you'll have  
to read the rest of the article, what it does not do, due to  
security concerns and lazyness is make the upload folder 
writable too again, if that's your problem try doing a :  
```
chown root:sftpuser /sftp/sftpuser/upload
chmod 770 -R /sftp/sftpuser/upload 
```  
What it will fix on the other hand is if files will not display,  
and if you can't get in with any SFTP users but normal users work fine.  

There may be some helpful information hidden in your **auth.log** as well:
```cat /var/log/auth.log | grep sshd ```  

One last point to bring across is to remove an sftp user,
etc...

## Why chrooted SFTP is such a pain
To be completed!













