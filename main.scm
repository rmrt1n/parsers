(import (scheme base)
        (scheme write)
        (lexer)
        (parser)
        (utils))

(define (main)
  (let loop ((i 1))
    (display "> ")
    (let* ((inp (read-line))
           (tokens (tokenize inp)))
      (display
       (eval-ast
        (if (positive? i)
          (rec-asc-parse tokens)
          (rec-desc-parse tokens))))
      (newline))
    (loop (* -1 i))))

(main)

