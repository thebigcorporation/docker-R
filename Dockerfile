# SPDX-License-Identifier: GPL-2.0
ARG BASE_IMAGE
FROM $BASE_IMAGE as base

RUN apt -y update -qq && apt -y upgrade && DEBIAN_FRONTEND=noninteractive \
	apt -y install apt-utils bzip2 curl wget \
	r-base r-bioc-snpstats r-cran-genetics \
	r-cran-optparse r-cran-qqman \
	r-cran-tidyverse

ENTRYPOINT [ "Rscript" ]
