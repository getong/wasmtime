;;! target = "x86_64"
;;! flags = "-W function-references,gc -C collector=drc"
;;! test = "optimize"

(module
  (type $ty (array (mut i64)))

  (func (param i64 i64 i64) (result (ref $ty))
    (array.new_fixed $ty 3 (local.get 0) (local.get 1) (local.get 2))
  )
)
;; function u0:0(i64 vmctx, i64, i64, i64, i64) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     sig0 = (i64 vmctx, i32, i32, i32, i32) -> i64 tail
;;     fn0 = colocated u1:27 sig0
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i64, v3: i64, v4: i64):
;;                                     v45 = iconst.i64 0
;; @0025                               trapnz v45, user18  ; v45 = 0
;; @0025                               v6 = iconst.i32 32
;;                                     v46 = iconst.i32 24
;; @0025                               v12 = uadd_overflow_trap v6, v46, user18  ; v6 = 32, v46 = 24
;; @0025                               v15 = iconst.i32 -1476395008
;; @0025                               v13 = iconst.i32 0
;; @0025                               v18 = iconst.i32 8
;; @0025                               v19 = call fn0(v0, v15, v13, v12, v18)  ; v15 = -1476395008, v13 = 0, v18 = 8
;; @0025                               v7 = iconst.i32 3
;; @0025                               v22 = load.i64 notrap aligned readonly can_move v0+40
;; @0025                               v20 = ireduce.i32 v19
;; @0025                               v23 = uextend.i64 v20
;; @0025                               v24 = iadd v22, v23
;;                                     v37 = iconst.i64 24
;; @0025                               v25 = iadd v24, v37  ; v37 = 24
;; @0025                               store notrap aligned v7, v25  ; v7 = 3
;;                                     v34 = iconst.i64 32
;;                                     v59 = iadd v24, v34  ; v34 = 32
;; @0025                               store notrap aligned little v2, v59
;;                                     v61 = iconst.i64 40
;;                                     v67 = iadd v24, v61  ; v61 = 40
;; @0025                               store notrap aligned little v3, v67
;;                                     v69 = iconst.i64 48
;;                                     v75 = iadd v24, v69  ; v69 = 48
;; @0025                               store notrap aligned little v4, v75
;; @0029                               jump block1
;;
;;                                 block1:
;; @0029                               return v20
;; }
