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
sudo useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME

#Creat the .ssh directory
sudo mkdir /home/$USERNAME/.ssh

#Copy the public key
sudo cp public-keys/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys


#Set correct permissions
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "User $USERNAME configuration for passwordless SSH login."
