(define-library (utils)
  (import (scheme base)
          (scheme write)
          (scheme eval)
          (scheme repl))
  (export syntax-err eval-ast displayln)
  (begin
    (define (syntax-err)
      (error "err syntax error"))

    (define (eval-ast ast)
      (if (null? ast)
        ""
        (let* ((result (eval ast (interaction-environment)))
               (real-num (inexact result)))
          (if (zero? (floor-remainder real-num 1))
            result
            real-num))))

    (define (displayln str)
      (display str)
      (newline))
    ))

