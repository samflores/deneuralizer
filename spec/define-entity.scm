(load "spec.scm")
(load "../entity.scm")

(describe "Define entity"
  (it "should create an entity structure"
      (let
        ([expected '((table . users)
                     (fields
                       ((name . id) (type . integer) (serial . #t) (key . #t))))])
        (should equal?  expected (define-entity users))))

  (it "should allow definition of several fields"
      (let
        ([expected '((table . users)
                     (fields
                       ((name . id) (type . integer) (serial . #t) (key . #t))
                       ((name . username) (type . string) (required . #t))))])
        (should equal?
                expected
                (define-entity users
                               (string-field username (required #t)))))))
