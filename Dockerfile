ARG BASE_IMAGE
FROM $BASE_IMAGE as base

# SPDX-License-Identifier: GPL-2.0

# user data provided by the host system via the make file
# without these, the container will fail-safe and be unable to write output
ARG USERNAME
ARG USERID
ARG USERGNAME
ARG USERGID

# Put the user name and ID into the ENV, so the runtime inherits them
ENV USERNAME=${USERNAME:-nouser} \
    USERID=${USERID:-65533} \
    USERGID=${USERGID:-nogroup}

RUN apt -y update -qq && apt -y upgrade && DEBIAN_FRONTEND=noninteractive \
	apt -y install apt-utils bzip2 curl g++ libcurl4-openssl-dev wget \
	r-base r-cran-devtools r-bioc-snpstats r-cran-genetics r-cran-ggplot2 \
	r-cran-optparse r-cran-qqman \
	r-cran-tidyverse

# FROM base as rbuilder
WORKDIR /app
COPY scripts .
RUN Rscript devtools.R

# Set the user and group. This will allow output only where the
# user has write permissions
RUN groupadd -g $USERGID $USERGNAME && \
	useradd -m -u $USERID -g $USERGID $USERNAME && \
	adduser $USERNAME $USERGNAME

USER $USERNAME

ENTRYPOINT [ "Rscript" ]
