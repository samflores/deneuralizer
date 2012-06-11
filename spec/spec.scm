(define (describe title . statements)
  (let*
    ([results (map run statements)])
    (newline)
    (map report (filter not-successful? results))))

(define-syntax it
  (syntax-rules ()
    [(_ title) (cons title pending)]
    [(_ title statement ...) (cons title (lambda () statement ...))]))

(define (should op expected real)
  (if (op expected real)
    #t
    (list expected real)))

(define (run example)
  (let
    ([result ((cdr example))])
    (display (if (null? result) "*" (if result "." "F")))
    (cons (car example) result)))

(define (report example)
  (let
    ([result (cdr example)])
    (display (if (null? result)
               "*: "
               (if (list? result)
                 "F: ")))
    (display (car example))
    (if (list? result)
      (begin (newline)
             (display "expected: ")
             (display (car result)) (newline)
             (display "got     : ")
             (display (cdr result)) (newline)))
    (newline)
    result))

(define (not-successful? x)
  (not (eq? (cdr x) #t)))

(define (pending) '())

