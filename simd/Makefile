TOP?=..
CONFIG?=config.mk
include $(TOP)/$(CONFIG)

ifneq (,$(findstring x86,$(ARCH)))
	SIMD=sse2 avx avx2 fma4
	sse2_CFLAGS=-DENABLE_SSE2 -msse2
	avx_CFLAGS=-DENABLE_AVX -mavx
	avx2_CFLAGS=-DENABLE_AVX2 -mavx2 -mfma
	fma4_CFLAGS=-DENABLE_FMA4 -mavx -mfma4
else ifneq (,$(findstring arm,$(ARCH)))
	SIMD=neon
	neon_CFLAGS=-mfpu=neon
endif

TARGET_PREFIX=$(addprefix libsleefsimddp-, $(SIMD)) $(addprefix libsleefsimdsp-, $(SIMD))
LIB=$(addsuffix .so, $(TARGET_PREFIX)) $(addsuffix .a, $(TARGET_PREFIX))
TARGETS=$(addprefix iut-, $(SIMD)) $(LIB)
HEADER=$(addsuffix .h,$(addprefix helper, $(SIMD))) dd.h df.h nonnumber.h sleefsimd.h

getarch=$(lastword $(subst -, ,$(patsubst %.$(lastword $(subst ., ,$(1))),%,$(1))))

.PHONY: all clean testers test clean

all: $(TARGETS)

sleefsimdsp-%.o: sleefsimdsp.c
	$(CC) $($(call getarch,$@)_CFLAGS) -c -o $@ $< $(CFLAGS)

libsleefsimdsp-%.so: sleefsimdsp.c
	$(CC) $($(call getarch,$@)_CFLAGS) -c -o $@ $< $(SOCFLAGS)

sleefsimddp-%.o: sleefsimddp.c
	$(CC) $($(call getarch,$@)_CFLAGS) -c -o $@ $< $(CFLAGS)

libsleefsimddp-%.so: sleefsimddp.c
	$(CC) $($(call getarch,$@)_CFLAGS) -c -o $@ $< $(SOCFLAGS)

lib%.a: %.o
	$(AR) rcs $@ $<

iut-%: sleefsimddp-%.o sleefsimdsp-%.o iut.c
	$(CC) $($(call getarch,$@,)_CFLAGS) -o $@ $(CFLAGS) $^ $(LDFLAGS)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp -f $(LIB) $(DESTDIR)$(PREFIX)/lib
	mkdir -p $(DESTDIR)$(PREFIX)/include/sleef
	cp -f $(HEADER) $(DESTDIR)$(PREFIX)/include/sleef

uninstall:
	cd $(DESTDIR)$(PREFIX)/include/sleef && rm -f $(HEADER)

testers:
	$(MAKE) CONFIG=$(CONFIG) -C $(TESTER_DIR)

ifneq (,$(findstring arm,$(ARCH)))
test: iut-neon testers
	../tester/testersp --flushtozero ./iutneon
	../tester/testerspu1 --flushtozero ./iutneon
else
test: $(addprefix iut-, $(SIMD)) testers
	for simd in $(SIMD); do \
		for tester in $(TESTERS_PATH); do \
		    $$tester ./iut-$$simd; \
		done \
	done
endif

clean:
	rm -f *~ *.o *.s iut-* *.so *.a
