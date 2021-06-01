(define-library (utils)
  (import (scheme base)
          (scheme eval)
          (scheme repl))
  (export syntax-err eval-ast)
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
            real-num))))))

