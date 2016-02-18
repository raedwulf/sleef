# sleef version
VERSION=2.80

# paths
PREFIX=/usr/local
MANPREFIX=$(PREFIX)/share/man

# compiler
CC?=cc
AR?=ar
RANLIB?=ranlib
CFLAGS?=-Wall -DNDEBUG -O3 -Wall -Wno-unused -Wno-attributes
LDFLAGS?=-lm
SOCFLAGS?=$(CFLAGS) -shared -fPIC
CPPFLAGS?=

# testers
TESTER_DIR=$(TOP)/tester
TESTERS_PATH=$(addprefix $(TESTER_DIR)/,$(TESTERS))
TESTERS=tester testeru1 testersp testerspu1
