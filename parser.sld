(define-library (parser)
  (import (rec-desc)
          (rec-asc)
          (pratt))
  (export rec-desc-parse
          rec-asc-parse
          pratt-parse))

