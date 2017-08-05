FROM nvidia/cuda:8.0-devel-ubuntu16.04
WORKDIR /

RUN apt-get update \
    && apt-get -y install software-properties-common \
    wget

RUN mkdir /miner && \
    cd /miner && \
    wget https://github.com/ethereum-mining/ethminer/releases/download/v0.12.0.dev1/ethminer-0.12.0.dev1-Linux.tar.gz && \
    tar -xvf ethminer-0.12.0.dev1-Linux.tar.gz && \
    cd bin/ 
    
ENTRYPOINT ["/miner/bin/ethminer", "-U", "-S", "us2.ethermine.org:4444", "-O", "A6127C90e07fdB0eF881516A745901FAB5438E6b.$(hostname)"]
