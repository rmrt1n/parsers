(import (scheme base)
        (scheme write)
        (lexer)
        (parser)
        (utils))

(define lookup
  (list rec-desc-parse rec-asc-parse pratt-parse))

(define (main)
  (let loop ((i 0))
    (display "> ")
    (let* ((inp (read-line))
           (tokens (tokenize inp)))
      (display
       (eval-ast
        ((list-ref lookup (remainder i 3)) tokens)))
      (newline))
    (display (remainder i 3))
    (loop (+ 1 i))))

(main)

