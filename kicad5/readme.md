# KiCad
[KiCad](http://www.kicad-pcb.org/) is an open-source software tool for the creation of electronic schematic diagrams and PCB artwork. 

# How to use
## Installation
1. Install docker and adjust the prmissions the X server host
```bash
$ curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
$ xhost +local:docker
```
2. Add your user to the docker group.
```bash
$ sudo usermod -aG docker $USER
```
3. Run install script
```bash
$ cd kicad5/ && ./install.sh
```

