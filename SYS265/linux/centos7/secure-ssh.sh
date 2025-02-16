#secure-ssh.sh
#author michael-D-S
#creates a new ssh user using $1 parameters
#adds a public key from the local repo or curled from the remote repo
#removes root ability to the ssh in
#!/bin/bash

USERNAME=$1
GITHUB_URL="https://raw.githubusercontent.com/michael-D-S/SYS-265/refs/heads/main/SYS265/linux/public-keys/id_rsa.pub"

if [ -z "$USERNAME" ]; then
 echo "Usage: ./secure-ssh.sh <username>"
 exit 1
fi

#create the user
sudo useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME

#Creat the .ssh directory
sudo mkdir /home/$USERNAME/.ssh

#Download the public key from GitHub
sudo curl -s "$GITHUB_URL" -o /tmp/id_rsa.pub

#Copy the public key
sudo cp /tmp/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

#Remove the Temporary key
sudo rm /tmp/id_rsa.pub

#Set correct permissions
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "User $USERNAME configuration for passwordless SSH login."
