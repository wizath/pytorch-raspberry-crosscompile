FROM balenalib/raspberrypi3
# great feature from balena images that allow xcompile!
RUN [ "cross-build-start" ]

WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y git
RUN git clone -b v0.4.1 --recursive https://github.com/pytorch/pytorch ./pytorch

WORKDIR /usr/src/app/pytorch
# deps
RUN sed -i 's/jessie/stretch/g' /etc/apt/sources.list && apt-get update && apt-get install -y gcc-6 g++-6
RUN apt-get install -y libopenblas-dev cython libatlas-dev m4 libblas-dev python3-dev cmake python3-yaml python3-pip python3-setuptools git make wget libffi-dev

# https://gist.github.com/fgolemo/e19ef13183f1a4b5b59c24ae2ae31273
RUN pip3 install setuptools wheel typing numpy pyyaml cffi
ARG CC=/usr/bin/gcc-6
ARG CXX=/usr/bin/g++-6
# cmake 3.4
RUN wget https://cmake.org/files/v3.4/cmake-3.4.1.tar.gz && tar -xvzf cmake-3.4.1.tar.gz && cd cmake-3.4.1 && ./bootstrap && make && make install && cd .. && rm -rf cmake-3.4.1.tar.gz

# build pytorch
RUN NO_CUDA=1 NO_DISTRIBUTED=1 python3 setup.py build

RUN [ "cross-build-end" ]
