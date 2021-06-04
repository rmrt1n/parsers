(import (scheme base)
        (scheme write)
        (scheme time)
        (chibi match)
        (lexer)
        (parser)
        (utils))

(define lookup
  (list rec-desc-parse rec-asc-parse pratt-parse))

(define (time fn tokens)
  (let ((start (current-second)))
    (let ((result (eval-ast (fn tokens))))
      (list result
          (- (current-second) start)))))

(define (main)
  (let loop ((i 0))
    (display "> ")
    (let* ((inp (read-line))
           (tokens (tokenize inp))
           (parse-fn (list-ref lookup (remainder i 3))))
      (match-let (((result dur) (time parse-fn tokens)))
        (displayln* result parse-fn)
        (display* "time taken: " dur " seconds.\n")))
    (loop (+ 1 i))))

(main)

