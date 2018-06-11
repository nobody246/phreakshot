(use posix)
(load "config.scm")


(define (start-server)
  (process-run "adb start-server"))

(define (z #!key (duration .350))
  (process-wait
   (process-run
    (string-append "sleep " (number->string duration)))))
    
  



(define (tap xy)
  (process-run (sprintf "adb shell 'input touchscreen tap ~s ~s'"
			(car xy)
			(cadr xy))))

(define (tap-l xy #!key (duration-ms 200))
  (process-run (sprintf "adb shell 'input touchscreen swipe ~s ~s ~s ~s ~s'"
			(car xy)
			(cadr xy)
			(car xy)
			(cadr xy)
			duration-ms)))

(define (clear-all)
  (tap (alist-ref 'sq-btn positions))
  (z)
  (tap (alist-ref 'cl-btn positions))
  (z)
  (tap (alist-ref 'cr-btn positions))
  (z))


(define (start-keypad)
  (tap-l xy: (alist-ref 'start-keypad positions)))

(define (press-key digit)
  (tap (alist-ref digit positions)))

(define (process-digit-str digit-str)
  (and-let* ((curr-digit (> (string-length digit-str) 0))
	     (curr-digit (car (string->list digit-str)))
	     (curr-digit (string->symbol
			  (string-append "d"
					 (list->string `(,curr-digit)))))
	     (curr-digit (alist-ref curr-digit positions)))
    (tap curr-digit)
    (z)
    (set! last-ms-time (current-milliseconds))
    (process-digit-str (list->string (cdr (string->list digit-str))))))

      

