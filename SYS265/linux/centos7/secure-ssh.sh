#secure-ssh.sh
#author michael-D-S
#creates a new ssh user using $1 parameters
#adds a public key from the local repo or curled from the remote repo
#removes root ability to the ssh in
#!/bin/bash

USERNAME=$1

if [ -z "$USERNAME" ]; then
 echo "Usage: ./secure-ssh.sh <username>"
 exit 1
fi

#create the user
sudo adduser $USERNAME

#Creat the .ssh directory
sudo mkdir /home/$USERNAME/.ssh

#append the public key to authroized_key
sudo cat ssh/web01_id_rsa.pub >> /home/$USERNAME/.ssh/authorized_keys

#Set correct permissions
sudo chown $USERNAME:$USERNAME /home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "User $USERNAME configuration for passwordless SSH login."
