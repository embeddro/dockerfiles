#!/bin/bash
#!/bin/bash
#Script build or pull docker image with all necessary parameters
#
# Author: Aleksei Prusakov
# Created: 2018.11.12
# Modified: 2018.11.12

DIR="$(dirname $(readlink -f $0))"
source $DIR/config.sh

$( docker ps -a | grep $docker_container_name > /dev/null )
if [ $? -eq 0 ] ; then
	# Container exists 
	docker container rm $docker_container_name 
fi

$( docker images -a | grep $docker_image_name > /dev/null )
if [ $? -eq 0 ] ; then
	docker image rm $docker_image_name
fi

xdg-desktop-icon uninstall --novendor KiCad.desktop
xdg-icon-resource uninstall --novendor --size 64 kicad
rm -f $DIR/KiCad.desktop
rm -f $DIR/kicad.png

