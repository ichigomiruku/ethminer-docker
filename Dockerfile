FROM nvidia/cuda:8.0-devel-ubuntu16.04
WORKDIR /

RUN apt-get update \
    && apt-get -y install software-properties-common \
    && apt-get update \
    && apt-get install -y \
     cmake \
     libcryptopp-dev \
     libleveldb-dev \
     libjsoncpp-dev \
     libjsonrpccpp-dev \
     libboost-all-dev \
     libgmp-dev \
     libreadline-dev \
     libcurl4-gnutls-dev \
     ocl-icd-libopencl1 \
     opencl-headers \
     mesa-common-dev \
     libmicrohttpd-dev

RUN mkdir /miner && \
    cd /miner && \
    wget https://github.com/ethereum-mining/ethminer/releases/download/v0.12.0.dev1/ethminer-0.12.0.dev1-Linux.tar.gz && \
    tar -xvf ethminer-0.12.0.dev1-Linux.tar.gz && \
    cd bin/ 
    
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

ENTRYPOINT ["/miner/bin/ethminer", "-U" , "--farm-recheck 200", "-F 192.168.1.153:8080"]
