# SPDX-License-Identifier: GPL-2.0
# ------------------------------------------------------------------------------
ARG BASE
FROM $BASE

ENV TZ="UTC"

RUN apt -y update -qq && apt -y upgrade && DEBIAN_FRONTEND=noninteractive \
	apt -y install --no-install-recommends \
	apt-utils bzip2 curl make \
	r-base r-base-dev && \
	apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/*
# ------------------------------------------------------------------------------
