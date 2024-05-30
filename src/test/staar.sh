#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
Rscript -e "library('Matrix'); library(mice); library(GMMAT); \
    library(STAAR); sessionInfo(); STAAR;\
    library('MultiSTAAR'); sessionInfo(); MultiSTAAR; \
    library('MetaSTAAR'); sessionInfo(); MetaSTAAR; "
