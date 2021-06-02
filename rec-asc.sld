(define-library (rec-asc)
  (import (scheme base)
          (chibi match)
          (utils))
  (export rec-asc-parse)
  (begin
    (define (rec-asc-parse tokens)
      (if (null? tokens)
        '()
        (car (state0 tokens))))

    (define (state0 tokens)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
       (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base))
                     ;; ((term tl) (state3 tl factor))
                     ((expr tl) (state2 tl factor)))
          (state1 tl expr))))

    (define (state1 tokens node)
      (let loop ((tokens tokens)
                 (node node))
        (match tokens
          (() (list node tokens))
          (('PLUS tl ...)
           (match-let (((node tokens) (state10 tl node)))
             (loop tokens node)))
          (('MINUS tl ...)
           (match-let (((node tokens) (state11 tl node)))
             (loop tokens node)))
          (_ (syntax-err)))))

    (define (state2 tokens node)
      (let loop ((tokens tokens)
                 (node node))
        (match tokens
          (() (list node tokens))
          (('STAR tl ...)
           (match-let (((node tokens) (state12 tl node)))
             (loop tokens node)))
          (('SLASH tl ...)
           (match-let (((node tokens) (state13 tl node)))
             (loop tokens node)))
          (('PERCENT tl ...)
           (match-let (((node tokens) (state14 tl node)))
             (loop tokens node)))
          (((not (or 'NUMBER 'LPAREN 'CARET)) tl ...)
           (list node tokens))
          (_ (syntax-err)))))

    ;; (define (state3 tokens node)
      ;; (match tokens
        ;; (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        ;; (_ (list node tokens))))

    (define (state4 tokens node)
      (match tokens
        (('CARET tl ...) (state15 tl node))
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list node tokens))))
  
    ;; (define state5 state3)

    ;; (define (list hd tl)
      ;; (match (cdr tokens)
        ;; (((or (? number? hd) 'LPAREN) tl ...) (syntax-err))
        ;; (_ (list (car tokens) (cdr tokens)))))

    (define (state7 tokens)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     )
          (state16 tl base))))

    (define (state8 tokens)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     )
          (state17 tl base))))

    (define (state9 tokens)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base))
                     ;; ((term tl) (state3 tl factor))
                     ((expr tl) (state2 tl factor)))
          (state18 tl expr))))
    
    (define (state10 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
                     ;; ((term tl) (state3 tl factor)))
          (state19 tl node factor))))

    (define (state11 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
                     ;; ((term tl) (state3 tl factor)))
          (state20 tl node factor))))

    (define (state12 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
          (state21 tl node factor))))

    (define (state13 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
          (state22 tl node factor))))

    (define (state14 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
          (state23 tl node factor))))

    (define (state15 tokens node)
      (let ((node-tl
             (match tokens
               (((? number? hd) tl ...) (list hd tl))
               (('PLUS tl ...) (state7 tl))
               (('MINUS tl ...) (state8 tl))
               (('LPAREN tl ...) (state9 tl))
               (_ (syntax-err)))))
        (match-let* (((base tl) node-tl)
                     ;; ((power tl) (state5 tl base))
                     ((factor tl) (state4 tl base)))
          (state24 tl node factor))))

    (define (state16 tokens node)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(+ ,node) tokens))))

    (define (state17 tokens node)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(- ,node) tokens))))

    (define (state18 tokens node)
      (let loop ((tokens tokens)
                 (node node))
        (match tokens
          (('PLUS tl ...)
           (match-let (((node tokens) (state10 tl node)))
             (loop tokens node)))
          (('MINUS tl ...)
           (match-let (((node tokens) (state11 tl node)))
             (loop tokens node)))
          (('RPAREN tl ...)
           (list node tl))
           ;; (state25 tl node))
          (_ (syntax-err)))))

    (define (state19 tokens left right)
      (let loop ((tokens tokens)
                 (right right))
        (match tokens
          (('STAR tl ...)
           (match-let (((right tokens) (state12 tl right)))
             (loop tokens right)))
          (('SLASH tl ...)
           (match-let (((right tokens) (state13 tl right)))
             (loop tokens right)))
          (('PERCENT tl ...)
           (match-let (((right tokens) (state14 tl right)))
             (loop tokens right)))
          (((or 'NUMBER 'LPAREN 'CARET) tl ...)
           (syntax-err))
          (_ (list `(+ ,left ,right) tokens)))))

    (define (state20 tokens left right)
      (let loop ((tokens tokens)
                 (right right))
        (match tokens
          (('STAR tl ...)
           (match-let (((right tokens) (state12 tl right)))
             (loop tokens right)))
          (('SLASH tl ...)
           (match-let (((right tokens) (state13 tl right)))
             (loop tokens right)))
          (('PERCENT tl ...)
           (match-let (((right tokens) (state14 tl right)))
             (loop tokens right)))
          (((or 'NUMBER 'LPAREN 'CARET) tl ...)
           (syntax-err))
          (_ (list `(- ,left ,right) tokens)))))

    (define (state21 tokens left right)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(* ,left ,right) tokens))))

    (define (state22 tokens left right)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(/ ,left ,right) tokens))))

    (define (state23 tokens left right)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(remainder ,left ,right) tokens))))

    (define (state24 tokens left right)
      (match tokens
        (((or 'NUMBER 'LPAREN) tl ...) (syntax-err))
        (_ (list `(expt ,left ,right) tokens))))

    ;; (define state25 state3)
    ))

