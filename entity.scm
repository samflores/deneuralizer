(use-modules (ice-9 regex))

(define-syntax define-entity
  (syntax-rules ()
    [(_ entity-name)
     (define-entity entity-name '())]
    [(_ entity-name field-definition)
     (list
       (cons 'table 'entity-name)
       (cons 'fields (append (define-fields (integer-field id (serial #t) (key #t)))
                             (define-fields field-definition))))]))

(define-syntax define-fields
  (syntax-rules ()
    [(_ (fldtype fldname))
     '()]
    [(_ (fldtype fldname (prop val) ...))
     (list
       (append
         (list
           (cons 'name 'fldname)
           (cons 'type (string->symbol
                         (regexp-substitute
                           #f
                           (string-match
                             "([a-z]+)-field"
                             (symbol->string 'fldtype))
                           1))))
         (define-field-properties (prop val) ...)))]))

(define-syntax define-field-properties
  (syntax-rules ()
    [(_) '()]
    [(_ (prop val)) (list '(prop . val))]
    [(_ (prop-a val-a) (prop-b val-b) ...)
     (cons '(prop-a . val-a) (define-field-properties (prop-b val-b) ...))]))
