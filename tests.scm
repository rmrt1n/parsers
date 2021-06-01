(import (scheme base)
        (scheme write)
        (chibi test)
        (lexer)
        (parser)
        (utils))

(define (eval-math parse-fn str)
  (eval-ast (parse-fn (tokenize str))))


(define (test-basic fn)
  (test-group "basic binary operations"
    (test "100"
      100 (eval-math fn "100"))
    (test "-1"
      -1 (eval-math fn "-1"))
    (test "+2"
      2 (eval-math fn "+2"))
    (test "1 + 2"
      3 (eval-math fn "1 + 2"))
    (test "(1 - 2)"
      -1 (eval-math fn "(1 - 2)"))
    (test "1 * 2"
      2 (eval-math fn "1 * 2"))
    (test "1 / 2"
      0.5 (eval-math fn "1 / 2"))
    (test "(1 % 2)"
      1 (eval-math fn "(1 % 2)"))
    (test "1 ^ 2"
      1 (eval-math fn "1 ^ 2"))
    (test "(20)"
      20 (eval-math fn "(20)"))
    (test "(-2)"
      -2 (eval-math fn "(-2)"))
    (test "(((192)))"
      192 (eval-math fn "(((192)))"))))

(define (test-unary fn)
  (test-group "unary operations"
    (test "----1"
      1 (eval-math fn "----1"))
    (test "+++2"
      2 (eval-math fn "+++2"))
    (test "-+-+-2"
      -2 (eval-math fn "-+-+-2"))
    (test "+(--2)"
      2 (eval-math fn "+(--2)"))
    (test "+(-(+(-(+1))))"
      1 (eval-math fn "+(-(+(-(+1))))"))
    (test "3 + -2"
      1 (eval-math fn "3 + -2"))
    (test "3 * -2"
      -6 (eval-math fn "3 * -2"))
    (test "2 ^ -2"
      0.25 (eval-math fn "2 ^ -2"))
    (test "-3 ^ 2"
      9 (eval-math fn "-3 ^ 2"))))

(define (test-associativity fn)
  (test-group "associativity of operators"
    (test "1 + 2 + 3 + 4"
      10 (eval-math fn "1 + 2 + 3 + 4")) 
    (test "1 - 2 - 3 - 4"
      -8 (eval-math fn "1 - 2 - 3 - 4"))
    (test "1 * 2 * 3 * 4"
      24 (eval-math fn "1 * 2 * 3 * 4"))
    (test "4 / 2 / 2"
      1 (eval-math fn "4 / 2 / 2"))
    (test "4 % 3 % 2"
      1 (eval-math fn "4 % 3 % 2"))
    (test "2 ^ 3 ^ 2"
      512 (eval-math fn "2 ^ 3 ^ 2"))))

(define (test-precedence fn)
  (test-group "precedence of operators"
    (test "1 + 2 - 3"
      0 (eval-math fn "1 + 2 - 3"))
    (test "1 + 2 * 3"
      7 (eval-math fn "1 + 2 * 3"))
    (test "1 / 2 - 3"
      -2.5 (eval-math fn "1 / 2 - 3"))
    (test "3 * 4 % 5"
      2 (eval-math fn "3 * 4 % 5"))
    (test "2 * (3 + 4)"
      14 (eval-math fn "2 * (3 + 4)"))
    (test "3 - (3 + 4)"
      -4 (eval-math fn "3 - (3 + 4)"))
    (test "(10 - 4) / 2"
      3 (eval-math fn "(10 - 4) / 2"))
    (test "13 % 2 ^ 4"
      13 (eval-math fn "13 % 2 ^ 4"))
    (test "2 ^ (2 * 5)"
      1024 (eval-math fn "2 ^ (2 * 5)"))
    (test "2 ^ 3 * 3 + 1"
      25 (eval-math fn "2 ^ 3 * 3 + 1"))))

(define (test-err fn)
  (test-group "common errors"
    (test-error "1 2"
      (eval-math fn "1 2"))
    (test-error "1 +"
      (eval-math fn "1 +"))
    (test-error "2 * %"
      (eval-math fn "2 * %"))
    (test-error "^"
      (eval-math fn "^"))
    (test-error "(1 + 2"
      (eval-math fn "(1 + 2"))
    (test-error ")21"
      (eval-math fn ")21"))))

(define (test-all fn)
  (test-basic fn)
  (test-unary fn)
  (test-associativity fn)
  (test-precedence fn)
  (test-err fn))

(display "testing recursive descent parser\n")
(test-all rec-desc-parse)
(newline)
(display "testing recursive ascent parser\n")
(test-all rec-asc-parse)
(newline)

