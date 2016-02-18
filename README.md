SLEEF 2.80a with patched Makefiles
=================================

Original README
---------------

In this library, functions for evaluating some elementary functions
are implemented. The algorithm is intentended for efficient evaluation
utilizing SIMD instruction sets like SSE or AVX, but it is also fast
using usual scalar operations.

The package contains a few directories in which implementation in the
corresponding languages are contained. You can run "make test" in
order to test the functions in each directory.

The software is in public domain. You can use the software without any
obligation.


Author : Naoki Shibata

Main download page : http://shibatch.sourceforge.net/


Additions README
----------------

Vanilla code-base with largely rewritten Makefiles that allow
building shared and static libraries for SLEEF.

This code remains public domain.

Author : Tai Chi Minh Ralph Eastwood

Repository : https://github.com/raedwulf/sleef


History
-------

2.80a Added new GNU Makefiles to build the library and install into
a 'nix-based system.

2.80 Added support for ARM NEON. Added higher accuracy single
precision functions : sinf_u1, cosf_u1, sincosf_u1, tanf_u1, asinf_u1,
acosf_u1, atanf_u1, atan2f_u1, logf_u1, and cbrtf_u1.

2.70 Added higher accuracy functions : sin_u1, cos_u1, sincos_u1,
tan_u1, asin_u1, acos_u1, atan_u1, atan2_u1, log_u1, and
cbrt_u1. These functions evaluate the corresponding function with at
most 1 ulp of error.

2.60 Added the remaining single precision functions : powf, sinhf,
coshf, tanhf, exp2f, exp10f, log10f, log1pf. Added support for FMA4
(for AMD Bulldozer). Added more test cases. Fixed minor bugs (which
degraded accuracy in some rare cases).

2.50 Added support for AVX2. SLEEF now compiles with ICC.

2.40 Fixed incorrect denormal/nonnumber handling in ldexp, ldexpf,
sinf and cosf. Removed support for Go language.

2.31 Added sincosf.

2.30 Added single precision functions : sinf, cosf, tanf, asinf,
acosf, atanf, logf, expf, atan2f and cbrtf.

2.20 Added exp2, exp10, expm1, log10, log1p, and cbrt.

2.10 asin() and acos() are back. Added ilogb() and ldexp(). Added
hyperbolic functions.  Eliminated dependency on frexp, ldexp, fabs,
isnan and isinf.

2.00 All of the algorithm has been updated. Both accuracy and speed
are improved since version 1.10. Denormal number handling is also
improved.

1.10 AVX support is added. Accuracy tester is added.

1.00 Initial release
