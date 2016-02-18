TOP?=..
CONFIG?=config.mk
include $(TOP)/$(CONFIG)

ifneq (,$(findstring x86,$(ARCH)))
	SIMD=sse2 avx avx2 fma4
	DEFAULTSIMD?=sse2
	sse2_CFLAGS=-DENABLE_SSE2 -msse2
	avx_CFLAGS=-DENABLE_AVX -mavx
	avx2_CFLAGS=-DENABLE_AVX2 -mavx2 -mfma
	fma4_CFLAGS=-DENABLE_FMA4 -mavx -mfma4
	ENABLE_DP=1
else ifneq (,$(findstring arm,$(ARCH)))
	SIMD=neon
	DEFAULTSIMD?=neon
	neon_CFLAGS=-DENABLE_NEON -mfpu=neon
	ENABLE_DP=0
endif

TARGET_PREFIX=$(addprefix libsleefsimdsp-, $(SIMD))
ifeq ($(ENABLE_DP),1)
	TARGET_PREFIX+=$(addprefix libsleefsimddp-, $(SIMD))
endif
LIB=$(addsuffix .so, $(TARGET_PREFIX)) $(addsuffix .a, $(TARGET_PREFIX))
TARGETS=$(addprefix iut-, $(SIMD)) $(LIB)
HEADER=$(addsuffix .h,$(addprefix helper, $(SIMD))) dd.h df.h nonnumber.h sleefsimd.h

getarch=$(lastword $(subst -, ,$(patsubst %.$(lastword $(subst ., ,$(1))),%,$(1))))

.PHONY: all clean testers test clean

all: $(TARGETS)

sleefsimdsp-%.o: sleefsimdsp.c
	$(CC) -c -o $@ $< $(CFLAGS) $($(call getarch,$@)_CFLAGS)

libsleefsimdsp-%.so: sleefsimdsp.c
	$(CC) -c -o $@ $< $(SOCFLAGS) $($(call getarch,$@)_CFLAGS)

sleefsimddp-%.o: sleefsimddp.c
	$(CC) -c -o $@ $< $(CFLAGS) $($(call getarch,$@)_CFLAGS)

libsleefsimddp-%.so: sleefsimddp.c
	$(CC) -c -o $@ $< $(SOCFLAGS) $($(call getarch,$@)_CFLAGS)

lib%.a: %.o
	$(AR) rcs $@ $<

ifeq ($(ENABLE_DP),1)
iut-%: sleefsimddp-%.o sleefsimdsp-%.o iut.c
	$(CC) -o $@ $(CFLAGS) $($(call getarch,$@)_CFLAGS) $^ $(LDFLAGS)
else
iut-%: sleefsimdsp-%.o iut.c
	$(CC) -o $@ $(CFLAGS) $($(call getarch,$@)_CFLAGS) $^ $(LDFLAGS)
endif

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	for lib in $(LIB); do \
		cp -f $$lib $(DESTDIR)$(PREFIX)/lib/$$lib.$(MAJOR); \
		pushd $(DESTDIR)$(PREFIX)/lib; \
		ln -s $$lib.$(MAJOR) $$lib; \
		popd; \
	done
	pushd $(DESTDIR)$(PREFIX)/lib && \
	ln -s libsleefsimdsp-$(DEFAULTSIMD).a libsleefsimdsp.a && \
	ln -s libsleefsimddp-$(DEFAULTSIMD).a libsleefsimddp.a && \
	ln -s libsleefsimdsp-$(DEFAULTSIMD).so libsleefsimdsp.so && \
	ln -s libsleefsimddp-$(DEFAULTSIMD).so libsleefsimddp.so && popd
	mkdir -p $(DESTDIR)$(PREFIX)/include/sleef
	cp -f $(HEADER) $(DESTDIR)$(PREFIX)/include/sleef

uninstall:
	cd $(DESTDIR)$(PREFIX)/include/sleef && rm -f $(HEADER)

testers:
	$(MAKE) CONFIG=$(CONFIG) -C $(TESTER_DIR)

ifeq ($(ENABLE_DP),1)
test: $(addprefix iut-, $(SIMD)) testers
	for simd in $(SIMD); do \
		for tester in $(TESTERS_PATH); do \
		    $$tester ./iut-$$simd; \
		done \
	done
else
test:$(addprefix iut-, $(SIMD)) testers
	for simd in $(SIMD); do \
		../tester/testersp --flushtozero ./iut-$$simd; \
		../tester/testerspu1 --flushtozero ./iut-$$simd; \
	done
endif

clean:
	rm -f *~ *.o *.s iut-* *.so *.a
