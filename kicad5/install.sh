#!/bin/bash
#Script build or pull docker image with all necessary parameters
#
# Author: Aleksei Prusakov
# Created: 2018.11.12
# Modified: 2018.11.12

DIR="$(dirname $(readlink -f $0))"
source $DIR/config.sh

#Create/download dockerimage 
$( docker images -a | grep $docker_image_name > /dev/null )
if [ $? -ne 0 ] ; then
	if [[ $@ == *'--build-from-dockerfile'* ]]
	then
		$( docker images -a | grep $docker_image_name > /dev/null )
		if [ $? -ne 0 ] ; then
			echo "Building image from dockerfile"
			docker build -t $docker_image_name .
			if [ $? -gt 0 ] ; then
				echo "Build failed"
				exit 1
			fi
		else
			echo "The image $docker_image_name alrady exists. Skipping building"
		fi
	else
		echo "Downloading docker image from DockerHub"
		docker pull $docker_image_name
			if [ $? -gt 0 ] ; then
				echo "Downloading failed. Try to use key --build-from-dockerfile"
				exit 1
			fi
	fi
else
	echo "Image $docker_image_name already exist"
fi
$( docker ps -a | grep $docker_container_name > /dev/null )
if [ $? -ne 0 ] ; then
	echo "Creating container $docker_container_name ..."
	docker create  \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /home/$USER:/mnt/host \
		-e HOST_USER_NAME=$(id -u -n) \
		-e HOST_USER_GROUP=$(id -g -n) \
		-e UID=$(id -u) \
		-e GID=$(id -g) \
		--net=host \
		--name $docker_container_name \
		$docker_image_name
fi

docker cp $docker_container_name:/usr/share/icons/hicolor/64x64/apps/kicad.png $DIR/kicad.png
xdg-icon-resource install --novendor $DIR/kicad.png --size 64 kicad
cat <<EOF > KiCad.desktop
[Desktop Entry]
Type=Application
Terminal=true
Name=KiCad
Icon=kicad
Exec=$DIR/run.sh
EOF

xdg-desktop-icon install --novendor KiCad.desktop
rm $DIR/KiCad.desktop
rm $DIR/kicad.png
echo "KiCad image installed. Use desktop icon or './run' to start programm."
