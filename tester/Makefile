TOP?=..
CONFIG?=config.mk
include $(TOP)/$(CONFIG)

.PHONY: all clean

LDFLAGS+=-lmpfr
TARGETS=tester testersp testeru1 testerspu1

all: $(TARGETS)

tester%: tester%.c
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

clean:
	rm -f *~ *.o tester testersp testeru1 testerspu1
