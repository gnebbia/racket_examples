#lang htdp/bsl

(require 2htdp/image)
(require 2htdp/universe)

;; A cat that walks from left to right across the screen.

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))

(define SPEED 3)

(define MTS (empty-scene WIDTH HEIGHT))

(define CAT-IMG (bitmap "./img/cat.png"))



;; =================
;; Data definitions:

;; Cat is Number
;; interp. x position of the cat in screen coordinates
(define C1 0)           ;left edge
(define C2 (/ WIDTH 2)) ;middle
(define C3 WIDTH)       ;right edge
#;
(define (fn-for-cat c)
  (... c))

;; Template rules used:
;;  - atomic non-distinct: Number



;; =================
;; Functions:

;; Cat -> Cat
;; start the world with (main 0)
;; 
(define (main c)
  (big-bang c                                ; Cat
            (on-tick   advance-cat)          ; Cat -> Cat
            (to-draw   render)               ; Cat -> Image
            (on-key    handle-key)           ; Cat KeyEvent -> Cat
            (on-mouse  handle-mouse)))       ; Cat Integer Integer MouseEvent -> WS

;; Cat -> Cat
;; produce the next cat, by advancing it SPEED pixel(s) to right
(check-expect (advance-cat 3) (+ 3 SPEED))

;(define (advance-cat c) 0) ;stub

;<use template from Cat>

(define (advance-cat c)
  (+ c SPEED)) 


;; Cat -> Image
;; render the cat image at appropriate place on MTS 
(check-expect (render 4) (place-image CAT-IMG 4 CTR-Y MTS)) 
              
;(define (render c) MTS) ;stub

;<use template from Cat>

(define (render c)
  (place-image CAT-IMG c CTR-Y MTS)) 


;; Cat KeyEvent -> Cat
;; reset cat to left edge when space key is pressed
(check-expect (handle-key 10 " ")  0)
(check-expect (handle-key 10 "a") 10)
(check-expect (handle-key  0 " ")  0)
(check-expect (handle-key  0 "a")  0)

;(define (handle-key c ke) 0) ;stub

(define (handle-key c ke)
  (cond [(key=? ke " ") 0]
        [else c]))


;; Cat Integer Integer MouseEvent -> WS
;; reset cat to mouse position when a button on the mouse is clicked
(check-expect (handle-mouse   0   0   0 "button-down")   0)
(check-expect (handle-mouse  50  50 150 "button-down")  50)
(check-expect (handle-mouse 100 200 200 "button-up")   100)
(check-expect (handle-mouse 200 500 100 "enter")       200)

;(define (handle-mouse ws x y me) 0) ;stub

(define (handle-mouse ws x y me)
  (cond [(mouse=? me "button-down") x]
        [else ws]))


(main 0)
