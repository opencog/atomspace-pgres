;
; pgres-storage.scm -- Very abbreviated StorageNode demo.
;
; See the examples in the main AtomSpace examples directory
; for more complete demonstrations and explanations.
;
(use-modules (opencog) (opencog persist))
(use-modules (opencog persist-sql))

(define psn (PostgresStorageNode "postgres://opencog_tester:cheese@localhost/opencog_test"))

(cog-set-value!
   (Concept "asdf")
   (Predicate "my key")
   (StringValue "Humpty" "Dumpty"))
(Concept "asdf" (stv 0.318309886 0.36787944))

(cog-open psn)
(store-atom (Concept "asdf"))
(cog-close psn)

(cog-atomspace-clear)

(define psn (PostgresStorageNode "postgres://opencog_tester:cheese@localhost/opencog_test"))
(cog-open psn)
(fetch-atom (Concept "asdf"))
(cog-close psn)

(format #t "The Atom ~A has value ~A\n" (Concept "asdf")
	(cog-value (Concept "asdf") (Predicate "my key")))
