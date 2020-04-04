#lang htdp/bsl

(require 2htdp/image)
(require 2htdp/universe)


;; A fancy traffic light


;; =================
;; Constants:

; screen properties
(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))
(define CTR-X (/ WIDTH  2))
(define MTS (empty-scene WIDTH HEIGHT))


; traffic light properties
(define TL-CIRCLE-SIZE       30)
(define TL-WIDTH            100)
(define TL-HEIGHT           300)
(define TL-RAD  (/ TL-HEIGHT 3 2))    ; the radius for each light belonging to the traffic light
(define TL-BG (rectangle TL-WIDTH TL-HEIGHT "solid" "black"))




;; =================
;; Data definitions:

;; TL is one of:
;; - "red"
;; - "yellow"
;; - "green"
;; interp. the state of a traffic light

; Template for function operating on the TL enumeration
#;
(define (fn-for-tl c)
  (cond [(string=? x "red")    (... c)]
        [(string=? x "yellow") (... c)]
        [(string=? x "green")  (... c)]))



;; =================
;; Functions:

;; main: TL -> TL
;; start the world with the traffic light being "red" (main "red")
;; 
(define (main c)
  (big-bang c                                  ; Countdown
            (on-tick   next-state 2)           ; Countdown -> Countdown
            (to-draw   render-tl)))            ; Countdown -> Image

;; next-state: TL -> TL
;; produce the next traffic light state based on the consumed one
(check-expect (next-state "red") "green")
(check-expect (next-state "yellow") "red")
(check-expect (next-state "green") "yellow")


(define (next-state c)
  (cond [(string=? c "red")    "green"]
        [(string=? c "yellow") "red"]
        [(string=? c "green")  "yellow"]))


;; render-tl: TL -> Image
;; render the cat image at appropriate place on MTS
(check-expect (render-tl "red")    (place-image (tl->image "red")    CTR-X CTR-Y MTS))
(check-expect (render-tl "green")  (place-image (tl->image "green")  CTR-X CTR-Y MTS))
(check-expect (render-tl "yellow") (place-image (tl->image "yellow") CTR-X CTR-Y MTS))


(define (render-tl c)
  (cond [(string=? c "red") (place-image (tl->image "red") CTR-X CTR-Y MTS)]
        [(string=? c "yellow") (place-image (tl->image "yellow") CTR-X CTR-Y MTS)]
        [(string=? c "green") (place-image (tl->image "green") CTR-X CTR-Y MTS)]))
        
    


;; tl->image: TL -> Image
;; Produce the image of a traffic light with the specified light turned on
(check-expect (tl->image "red")
              (overlay (above (circle TL-RAD "solid"      "red")
                              (circle TL-RAD "outline" "yellow")
                              (circle TL-RAD "outline"  "green"))
                        TL-BG))

(check-expect (tl->image "yellow")
              (overlay (above (circle TL-RAD "outline"    "red")
                              (circle TL-RAD "solid"   "yellow")
                              (circle TL-RAD "outline"  "green"))
                       TL-BG))

(check-expect (tl->image "green")
              (overlay (above (circle TL-RAD "outline"    "red")
                              (circle TL-RAD "outline" "yellow")
                              (circle TL-RAD "solid"    "green"))
                       TL-BG))


(define (tl->image c)
    (cond [(string=? c "red")
         (overlay (above (circle TL-RAD "solid"      "red")
                         (circle TL-RAD "outline" "yellow")
                         (circle TL-RAD "outline"  "green"))
                  TL-BG)]
        [(string=? c "yellow")
         (overlay (above (circle TL-RAD "outline"    "red")
                         (circle TL-RAD "solid"   "yellow")
                         (circle TL-RAD "outline"  "green"))
                  TL-BG)]
        [(string=? c "green")
         (overlay (above (circle TL-RAD "outline"    "red")
                         (circle TL-RAD "outline" "yellow")
                         (circle TL-RAD "solid"   "green"))
                  TL-BG)]))

(main "red")
