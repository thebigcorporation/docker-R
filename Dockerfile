FROM ubuntu:20.04 as base
# these need to be overriden or the container will fail-safe
ARG USERNAME
ARG USERID
ARG USERGID

# Put the user name and ID into the ENV, so the runtime inherits them
ENV USERNAME=${USERNAME:-nouser} \
        USERID=${USERID:-65533} \
        USERGID=${USERGID:-nogroup}

RUN echo $USERNAME $USERID $USERGID

# match the building user. This will allow output only where the building
# user has write permissions
RUN useradd -m -u $USERID -g $USERGID $USERNAME

RUN apt -y update -qq && apt -y upgrade && apt -y install \
                openjdk-11-jdk \
		bzip2 curl \
		libgfortran5 libgomp1 liblzma5 libreadline8 libpcre3 wget

FROM base as builder

ARG R_MAJOR="R-3"
ARG RVER="R-3.6.3"

RUN DEBIAN_FRONTEND=noninteractive apt -y install \
                gcc g++ gfortran \
		libreadline-dev libbz2-dev libz-dev libcurl4-gnutls-dev \
		liblzma-dev libpcre3-dev \
		make

WORKDIR /src/

RUN wget https://cran.r-project.org/src/base/$R_MAJOR/$RVER.tar.gz
RUN gcc --version
RUN tar -xzf $RVER.tar.gz && cd $RVER && set -x && \
	./configure --with-x=no && make && make install

FROM base as release

WORKDIR /runtime
RUN chown -R $USERNAME:$USERGID /runtime
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/

USER $USERNAME

ENTRYPOINT [ "R" ]
