FROM ubuntu:20.04 as builder

ARG R_MAJOR="R-3"
ARG RVER="R-3.6.3"

RUN set -x && apt -y update -qq && apt -y upgrade &&  \
        DEBIAN_FRONTEND=noninteractive apt -y install \
                gcc g++ gfortran openjdk-11-jdk \
		libreadline-dev bzip2 libbz2-dev libz-dev \
		libcurl4-gnutls-dev curl \
		liblzma5 liblzma-dev libpcre3 libpcre3-dev \
		make wget

WORKDIR /src/

RUN wget https://cran.r-project.org/src/base/$R_MAJOR/$RVER.tar.gz
RUN gcc --version
RUN tar -xzf $RVER.tar.gz && cd $RVER && set -x && \
	./configure --with-x=no && make && make install

ENTRYPOINT [ "R" ]
