TOP=.
CONFIG?=config.mk
include $(CONFIG)

BUILD?=java purec simd
SUBDIRS?=$(BUILD) tester

.PHONY: all java purec simd tester test clean

all: $(BUILD)

java:
	$(MAKE) CONFIG=$(CONFIG) -C java

purec:
	$(MAKE) CONFIG=$(CONFIG) -C purec

simd:
	$(MAKE) CONFIG=$(CONFIG) -C simd

tester:
	$(MAKE) CONFIG=$(CONFIG) -C tester

install:
	for toinst in $(BUILD); do \
	    $(MAKE) CONFIG=$(CONFIG) -C $$toinst install; \
	done

uninstall:
	for toinst in $(BUILD); do \
	    $(MAKE) CONFIG=$(CONFIG) -C $$toinst uninstall; \
	done
	rmdir -f $(DESTDIR)$(PREFIX)/include/sleef

test:
	for totest in $(BUILD); do \
	    $(MAKE) CONFIG=$(CONFIG) -C $$totest test; \
	done

clean:
	rm -f *~
	for subdir in $(SUBDIRS); do \
	    $(MAKE) CONFIG=$(CONFIG) -C $$subdir clean; \
	done
