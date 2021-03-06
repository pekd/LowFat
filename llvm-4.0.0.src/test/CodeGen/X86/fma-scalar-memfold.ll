; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mcpu=core-avx2 | FileCheck %s --check-prefix=CHECK --check-prefix=AVX2
; RUN: llc < %s -mcpu=skx | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512
; RUN: llc < %s -mattr=fma4 | FileCheck %s --check-prefix=FMA4

target triple = "x86_64-unknown-unknown"

declare <4 x float> @llvm.x86.fma.vfmadd.ss(<4 x float>, <4 x float>, <4 x float>)
declare <4 x float> @llvm.x86.fma.vfmsub.ss(<4 x float>, <4 x float>, <4 x float>)
declare <4 x float> @llvm.x86.fma.vfnmadd.ss(<4 x float>, <4 x float>, <4 x float>)
declare <4 x float> @llvm.x86.fma.vfnmsub.ss(<4 x float>, <4 x float>, <4 x float>)

declare <2 x double> @llvm.x86.fma.vfmadd.sd(<2 x double>, <2 x double>, <2 x double>)
declare <2 x double> @llvm.x86.fma.vfmsub.sd(<2 x double>, <2 x double>, <2 x double>)
declare <2 x double> @llvm.x86.fma.vfnmadd.sd(<2 x double>, <2 x double>, <2 x double>)
declare <2 x double> @llvm.x86.fma.vfnmsub.sd(<2 x double>, <2 x double>, <2 x double>)

define void @fmadd_aab_ss(float* %a, float* %b) {
; CHECK-LABEL: fmadd_aab_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfmadd213ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmadd_aab_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfmaddss (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfmadd.ss(<4 x float> %av, <4 x float> %av, <4 x float> %bv)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fmadd_aba_ss(float* %a, float* %b) {
; CHECK-LABEL: fmadd_aba_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfmadd132ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmadd_aba_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfmaddss %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfmadd.ss(<4 x float> %av, <4 x float> %bv, <4 x float> %av)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fmsub_aab_ss(float* %a, float* %b) {
; CHECK-LABEL: fmsub_aab_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfmsub213ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmsub_aab_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfmsubss (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfmsub.ss(<4 x float> %av, <4 x float> %av, <4 x float> %bv)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fmsub_aba_ss(float* %a, float* %b) {
; CHECK-LABEL: fmsub_aba_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfmsub132ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmsub_aba_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfmsubss %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfmsub.ss(<4 x float> %av, <4 x float> %bv, <4 x float> %av)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fnmadd_aab_ss(float* %a, float* %b) {
; CHECK-LABEL: fnmadd_aab_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfnmadd213ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmadd_aab_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfnmaddss (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfnmadd.ss(<4 x float> %av, <4 x float> %av, <4 x float> %bv)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fnmadd_aba_ss(float* %a, float* %b) {
; CHECK-LABEL: fnmadd_aba_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfnmadd132ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmadd_aba_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfnmaddss %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfnmadd.ss(<4 x float> %av, <4 x float> %bv, <4 x float> %av)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fnmsub_aab_ss(float* %a, float* %b) {
; CHECK-LABEL: fnmsub_aab_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfnmsub213ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmsub_aab_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfnmsubss (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfnmsub.ss(<4 x float> %av, <4 x float> %av, <4 x float> %bv)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fnmsub_aba_ss(float* %a, float* %b) {
; CHECK-LABEL: fnmsub_aba_ss:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    vfnmsub132ss (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmsub_aba_ss:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; FMA4-NEXT:    vfnmsubss %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovss %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load float, float* %a
  %av0 = insertelement <4 x float> undef, float %a.val, i32 0
  %av1 = insertelement <4 x float> %av0, float 0.000000e+00, i32 1
  %av2 = insertelement <4 x float> %av1, float 0.000000e+00, i32 2
  %av  = insertelement <4 x float> %av2, float 0.000000e+00, i32 3

  %b.val = load float, float* %b
  %bv0 = insertelement <4 x float> undef, float %b.val, i32 0
  %bv1 = insertelement <4 x float> %bv0, float 0.000000e+00, i32 1
  %bv2 = insertelement <4 x float> %bv1, float 0.000000e+00, i32 2
  %bv  = insertelement <4 x float> %bv2, float 0.000000e+00, i32 3

  %vr = call <4 x float> @llvm.x86.fma.vfnmsub.ss(<4 x float> %av, <4 x float> %bv, <4 x float> %av)

  %sr = extractelement <4 x float> %vr, i32 0
  store float %sr, float* %a
  ret void
}

define void @fmadd_aab_sd(double* %a, double* %b) {
; CHECK-LABEL: fmadd_aab_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfmadd213sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmadd_aab_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfmaddsd (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfmadd.sd(<2 x double> %av, <2 x double> %av, <2 x double> %bv)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fmadd_aba_sd(double* %a, double* %b) {
; CHECK-LABEL: fmadd_aba_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfmadd132sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmadd_aba_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfmaddsd %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfmadd.sd(<2 x double> %av, <2 x double> %bv, <2 x double> %av)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fmsub_aab_sd(double* %a, double* %b) {
; CHECK-LABEL: fmsub_aab_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfmsub213sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmsub_aab_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfmsubsd (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfmsub.sd(<2 x double> %av, <2 x double> %av, <2 x double> %bv)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fmsub_aba_sd(double* %a, double* %b) {
; CHECK-LABEL: fmsub_aba_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfmsub132sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fmsub_aba_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfmsubsd %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfmsub.sd(<2 x double> %av, <2 x double> %bv, <2 x double> %av)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fnmadd_aab_sd(double* %a, double* %b) {
; CHECK-LABEL: fnmadd_aab_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfnmadd213sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmadd_aab_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfnmaddsd (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfnmadd.sd(<2 x double> %av, <2 x double> %av, <2 x double> %bv)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fnmadd_aba_sd(double* %a, double* %b) {
; CHECK-LABEL: fnmadd_aba_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfnmadd132sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmadd_aba_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfnmaddsd %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfnmadd.sd(<2 x double> %av, <2 x double> %bv, <2 x double> %av)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fnmsub_aab_sd(double* %a, double* %b) {
; CHECK-LABEL: fnmsub_aab_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfnmsub213sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmsub_aab_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfnmsubsd (%rsi), %xmm0, %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfnmsub.sd(<2 x double> %av, <2 x double> %av, <2 x double> %bv)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}

define void @fnmsub_aba_sd(double* %a, double* %b) {
; CHECK-LABEL: fnmsub_aba_sd:
; CHECK:       # BB#0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vfnmsub132sd (%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vmovlpd %xmm0, (%rdi)
; CHECK-NEXT:    retq
;
; FMA4-LABEL: fnmsub_aba_sd:
; FMA4:       # BB#0:
; FMA4-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; FMA4-NEXT:    vfnmsubsd %xmm0, (%rsi), %xmm0, %xmm0
; FMA4-NEXT:    vmovlpd %xmm0, (%rdi)
; FMA4-NEXT:    retq
  %a.val = load double, double* %a
  %av0 = insertelement <2 x double> undef, double %a.val, i32 0
  %av  = insertelement <2 x double> %av0, double 0.000000e+00, i32 1

  %b.val = load double, double* %b
  %bv0 = insertelement <2 x double> undef, double %b.val, i32 0
  %bv  = insertelement <2 x double> %bv0, double 0.000000e+00, i32 1

  %vr = call <2 x double> @llvm.x86.fma.vfnmsub.sd(<2 x double> %av, <2 x double> %bv, <2 x double> %av)

  %sr = extractelement <2 x double> %vr, i32 0
  store double %sr, double* %a
  ret void
}


