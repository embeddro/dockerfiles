#!/bin/bash
DIR="$(dirname $(readlink -f $0))"
source $DIR/config.sh
#if "kicad" container already exist, use it. Else create new container.
$( docker ps -a | grep $docker_container_name > /dev/null )
if [ $? -eq 0 ] ; then
        echo "Container $docker_container_name already exist. Starting container..."
	docker start $docker_container_name
else
        echo "Create container $docker_container_name"
	docker run -d \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /home/$USER:/mnt/host \
		-e HOST_USER_NAME=$(id -u -n) \
		-e HOST_USER_GROUP=$(id -g -n) \
		-e UID=$(id -u) \
		-e GID=$(id -g) \
		--net=host \
		--name $docker_container_name prus/kicad 

fi



