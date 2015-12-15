#lang racket

; "Pairwise greater than"
; list of ints (length N) -> list of ints (length N-1)
; the new list being the best choice for the row above it.
;
; Imagine that below is the bottom part of a triangle.
;
; Ex:
;      .......
;      1 2 3 4
;     0 0 9 0 0
;
; It is clear that 1 and 4 have only 0s as their choices--
; 2 and 3 have the more-valuable 9 available.
;
; (pw> '(0 0 9 0 0)) will look at each pair of elements: (0 0) (0 9) (9 0) (0 0)
;(0 0)(0 9)(9 0)(0 0), and pick the max of each
;   |   /    \   |
; '(0  9      9  0)
;
; '(0 9 9 0)
(define (pw> lis . acc)
  (cond 
    [(= 1 (length lis)) (or
                         (and (not (empty? acc)) acc)
                         lis)]
    [else
     (define 1st (first lis))
     (define 2nd (second lis))
     (apply pw> (cdr lis) (append acc (list (max 1st 2nd))))]))

; Repeatedly sum the second to last row with the pw> of the last row, until you have one value
(define (solve triangle)
  (define len (length triangle))
  (cond 
    [(= 1 len) (caar triangle)]
    [else
     (define lastrow (last triangle))
     (define otherow (list-ref triangle (- len 2)))
     (solve (append (take triangle (- len 2)) (list (map + (pw> lastrow) otherow))))]))
         
  
; Super succinct pw>. Probably slower because it iterates over 2 lists.
(define (p> li) (let ([a (for/list ([f (in-list li)] [s (in-list (cdr li))]) (max f s))])
                  (or
                   (and (not (empty? a)) a)
                   (car li))))
; Succinct solve
(define (s li) (foldl (λ (x acc) (p> (map + x acc)))
                      (build-list (length (last li)) (λ (_) 0))
                      (reverse li)))

(define tri '(   (3)
                (7 4)
               (2 4 6)
              (8 5 9 3)))