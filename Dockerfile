#
# Nheqminer Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV YOUR_URL your_url
ENV YOUR_WALLET your_wallet
ENV YOUR_WORKER your_worker
ENV YOUR_EMAIL your_email

#Update & install packages for installting add-apt-repository
RUN apt-get update && \
    apt-get install -y git cmake build-essential libboost-all-dev

# Update & install packages for installing ethereum
RUN git clone -b Linux https://github.com/nanopool/nheqminer.git && \
    cd nheqminer/cpu_xenoncat/Linux/asm/ && \
    sh assemble.sh && \
    cd ../../../Linux_cmake/nheqminer_cpu && \
    cmake . && \
    make -j $(nproc)

RUN find nheqminer -name *nheqminer*
RUN find nheqminer -name *nheqminer_cpu*

WORKDIR /nheqminer/Linux_cmake/nheqminer_cpu
CMD ls
#CMD /usr/bin/ethminer --farm-recheck 200 -F $YOUR_URL/$YOUR_WALLET/$YOUR_WORKER/$YOUR_EMAIL -C
CMD ./nheqminer_cpu -l $YOUR_URL -u $YOUR_WALLET/$YOUR_WORKER
