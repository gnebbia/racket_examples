#lang htdp/bsl

(require 2htdp/image)
(require 2htdp/universe)
;; An unstoppable countdown that goes to zero


;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH  2))
(define TEXT-SIZE 30)
(define TEXT-COLOR "black")

(define MTS (empty-scene WIDTH HEIGHT))




;; =================
;; Data definitions:

;; Countdown is Number[0,10]
;; interp. the number of seconds left to 0
(define C1 0)       ;finished
(define C2 10)      ;just started
(define C3 5)       ;half way

#;
(define (fn-for-cat c)
  (... c))

;; Template rules used:
;;  - atomic non-distinct: Interval



;; =================
;; Functions:

;; Countdown -> Countdown
;; start the world with (main 10)
;; 
(define (main c)
  (big-bang c                                ; Countdown
            (on-tick   decrease-cd 1)          ; Countdown -> Countdown
            (to-draw   render-cd)))            ; Countdown -> Image

;; Countdown -> Countdown
;; produce the next number to be displayed on the countdown
(check-expect (decrease-cd 3) (- 3 1))
(check-expect (decrease-cd 10) (- 10 1))
(check-expect (decrease-cd 1) 0)
(check-expect (decrease-cd 0) 0)

;(define (decrease-cd c) 0) ;stub

;<use template from Cat>

(define (decrease-cd c)
  (if (= c 0)
      0
      (- c 1))) 


;; Cat -> Image
;; render the cat image at appropriate place on MTS 
;(check-expect (render-cd c) (place-image CAT-IMG 4 CTR-Y MTS)) 
(check-expect (render-cd 3)  (place-image (text "3"  TEXT-SIZE TEXT-COLOR) CTR-X CTR-Y MTS))
(check-expect (render-cd 10) (place-image (text "10" TEXT-SIZE TEXT-COLOR) CTR-X CTR-Y MTS))
(check-expect (render-cd 1)  (place-image (text "1"  TEXT-SIZE TEXT-COLOR) CTR-X CTR-Y MTS))
(check-expect (render-cd 0)  (place-image (text "0"  TEXT-SIZE TEXT-COLOR) CTR-X CTR-Y MTS))

;(define (render-cd c) MTS) ;stub

;<use template from Cat>
(define (render-cd c)
  (place-image (text (number->string c) TEXT-SIZE TEXT-COLOR)
               CTR-X
               CTR-Y
               MTS))

(main 10)
