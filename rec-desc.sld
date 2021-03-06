(define-library (rec-desc)
  (import (scheme base)
          (chibi match)
          (utils))
  (export rec-desc-parse)
  (begin
    (define (rec-desc-parse tokens)
      (if (null? tokens)
        '()
        (car (parse-expr tokens))))

    (define (parse-expr tokens)
      (match-let (((left tokens) (parse-term tokens)))
        (let loop ((left left)
                   (tokens tokens))
          (match tokens
            (() (list left tokens))
            (('PLUS tl ...)
             (match-let (((right tl) (parse-term tl)))
               (loop `(+ ,left ,right) tl)))
            (('MINUS tl ...)
             (match-let (((right tl) (parse-term tl)))
               (loop `(- ,left ,right) tl)))
            (('RPAREN tl ...) (list left tokens))
            (_ (syntax-err))))))

    (define (parse-term tokens)
      (match-let (((left tokens) (parse-factor tokens)))
        (let loop ((left left)
                   (tokens tokens))
          (match tokens
            (('STAR tl ...)
             (match-let (((right tl) (parse-factor tl)))
               (loop `(* ,left ,right) tl)))
            (('SLASH tl ...)
             (match-let (((right tl) (parse-factor tl)))
               (loop `(/ ,left ,right) tl)))
            (('PERCENT tl ...)
             (match-let (((right tl) (parse-factor tl)))
               (loop `(remainder ,left ,right) tl)))
            (((or (? number? hd) 'LPAREN 'CARET) tl ...)
             (syntax-err))
            (_ (list left tokens))))))

    (define (parse-factor tokens)
      (match-let (((left tokens) (parse-power tokens)))
        (match tokens
          (('CARET tl ...)
           (match-let (((right tl) (parse-factor tl)))
             (list `(expt ,left ,right) tl)))
          (((or (? number? hd) 'LPAREN) tl ...)
           (syntax-err))
          (_ (list left tokens)))))

    (define (parse-power tokens)
      (match tokens
        (('PLUS tl ...)
         (match-let (((power tl) (parse-power tl)))
           (list `(+ ,power) tl)))
        (('MINUS tl ...)
         (match-let (((power tl) (parse-power tl)))
           (list `(- ,power) tl)))
        (((or (? number? hd) 'LPAREN) tl ...)
         (parse-base tokens))
        (_ (syntax-err))))

    (define (parse-base tokens)
      (match tokens
        (((? number? hd) tl ...)
         (list hd tl))
        (('LPAREN tl ...)
         (match-let (((expr tl) (parse-expr tl)))
           (match tl
             (('RPAREN tl ...) (list expr tl))
             (_ (error "err no closing paren")))))
        (_ (syntax-err))))
    ))

