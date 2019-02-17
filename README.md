# pytorch-raspberry-crosscompile
Docker image for easy cross compilation for pytorch library for Raspberry PI 3 SBC

Based on gist from @wngr
https://gist.github.com/wngr/d7de37e31551362223be39c80641c1b4

### Build
`docker build -t pytorch_rpi3 .`

### Copy build output
`docker run -it --rm -v $(PWD):/data pytorch_rpi3 /bin/bash`  
inside container: `cp -R /usr/src/app/pytorch /data/`

### Install depedencies
`sudo apt install libopenblas-base libopenjp2-7 libtiff5 libatlas-base-dev`

### Commands to install library 
`sudo python3 setup.py install --skip-build`  
`sudo pip3 install torchvision`
