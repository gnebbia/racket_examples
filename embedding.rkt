#lang racket

(provide stx-read-file)

(require (for-syntax racket))

(define-syntax (stx-read-file stx)
  (let* ((lst (syntax->datum stx))
         (base-name (cadr lst))
         (syntax-fname (syntax-source stx))
         (syntax-dir (path-only syntax-fname))
         (filename (build-path syntax-dir base-name)))
    (datum->syntax
      stx
      (with-input-from-file filename port->bytes))))

