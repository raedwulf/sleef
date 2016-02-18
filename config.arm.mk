ARCH=arm

include $(TOP)/common.mk

#FLOATABI?=softfp
FLOATABI=hardfp
CFLAGS=-O3 -Wall -Wno-unused -Wno-attributes -mfloat-abi=$(FLOATABI)
