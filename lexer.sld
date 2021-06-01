(define-library (lexer)
  (import (scheme base)
          (scheme char)
          (chibi match))
  (export tokenize)
  (begin
    ;; convert string to tokens
    (define (tokenize str)
      (tokenize-aux (string->list str)))

    ;; split list while condition
    (define (list-split-while fn ls)
      (let loop ((acc '())
                 (ls ls))
        (cond ((null? ls)
               (list (reverse acc) ls))
              ((fn (car ls))
               (loop (cons (car ls) acc) (cdr ls)))
              (else
               (list (reverse acc) ls))))) 

    ;; get digit token
    (define (get-digit hd tl)
      (let* ((splitted (list-split-while char-numeric? tl))
             (digit (string->number
                     (list->string
                      (cons hd (car splitted)))))
             (tl (cadr splitted)))
        (list digit tl)))

    ;; err unexpected char
    (define (unexpected-char c)
      (error (string-append "err unexpected character '"
                            (string c)
                            "'")))

    ;; main tokenizing function
    (define (tokenize-aux ls)
      (let loop ((acc '())
                 (ls ls))
        (match ls
          (()
           (reverse acc))
          (((? char-whitespace? hd) tl ...)
           (loop acc tl))
          (((? char-numeric? hd) tl ...)
           (let ((splitted (get-digit hd tl)))
             (loop (cons (car splitted) acc) (cadr splitted))))
          ((#\+ tl ...)
           (loop (cons 'PLUS acc) tl))
          ((#\- tl ...)
           (loop (cons 'MINUS acc) tl))
          ((#\* tl ...)
           (loop (cons 'STAR acc) tl))
          ((#\/ tl ...)
           (loop (cons 'SLASH acc) tl))
          ((#\% tl ...)
           (loop (cons 'PERCENT acc) tl))
          ((#\^ tl ...)
           (loop (cons 'CARET acc) tl))
          ((#\( tl ...)
           (loop (cons 'LPAREN acc) tl))
          ((#\) tl ...)
           (loop (cons 'RPAREN acc) tl))
          ((hd tl ...)
           (unexpected-char hd))
          (_ (error "err lexing error")))))
    ))

