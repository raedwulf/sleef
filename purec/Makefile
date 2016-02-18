TOP?=..
CONFIG?=config.mk
include $(TOP)/$(CONFIG)

.PHONY: all testers test install clean

LIB=libsleefdp.a libsleefsp.a libsleefdp.so libsleefsp.so
HEADER=sleef.h

all: $(LIB) iut

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

lib%.so: %.c
	$(CC) -c -o $@ $< $(SOCFLAGS)

lib%.a: %.o
	$(AR) rcs $@ $<

iut: iut.o sleefdp.o sleefsp.o
	$(CC) -o $@ $(CFLAGS) $^ $(LDFLAGS)

testers:
	$(MAKE) CONFIG=$(CONFIG) -C $(TESTER_DIR)

test: iut testers
	for tester in $(TESTERS_PATH) ; do \
	    $$tester ./iut; \
	done

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp -f $(LIB) $(DESTDIR)$(PREFIX)/lib
	mkdir -p $(DESTDIR)$(PREFIX)/include/sleef
	cp -f $(HEADER) $(DESTDIR)$(PREFIX)/include/sleef

uninstall:
	cd $(DESTDIR)$(PREFIX)/include/sleef && rm -f $(HEADER)

clean:
	rm -f *~ *.o iut
