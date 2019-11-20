#!/bin/sh


$( id -u $HOST_USER_NAME > /dev/null && id -g $HOST_GROUP_NAME > /dev/null )
#group and user not exist (first time)
if [ $? -ne 0 ] ; then
	echo "Добовляем пользователя $HOST_USER_NAME : $UID  и группу $HOST_USER_GROUP : $GID "
	groupadd -g $GID -o kicad_users ;
	useradd -m -g $GID -o -s /bin/bash -u $UID $HOST_USER_NAME ;
	echo "$HOST_USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$HOST_USER_NAME ;
	chmod 0440 /etc/sudoers.d/$HOST_USER_NAME ;
	sudo -u $HOST_USER_NAME -H sh -c "mkdir -p /home/$HOST_USER_NAME"
	ln -s /mnt /home/$HOST_USER_NAME/mnt
	HOME="/home/$HOST_USER_NAME"
fi
sudo -u $HOST_USER_NAME -H sh -c "kicad"




