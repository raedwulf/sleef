ARCH=arm

#FLOATABI?=softfp
FLOATABI?=hardfp
CFLAGS=-O3 -Wall -Wno-unused -Wno-attributes -mfloat-abi=$(FLOATABI)

include $(TOP)/common.mk
