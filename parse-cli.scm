(define expected-args '(cruise-control dict-file pin-len start end pause))

(define (print-gun)
  (for-each
   (lambda (x)
     (print x))
   `("        .____."
     "   xuu$``$$$uuu."
     " . $``$  $$$`$$$"
     "dP*$  $  $$$ $$$"
     "?k $  $  $$$ $$$"
     " $ $  $  $$$ $$$"
     " \":$  $  $$$ $$$"
     "  N$  $  $$$ $$$"
     "  $$  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $$#$  $$$ $$$"
     "   $$'$  $$$ $$$"
     "   $$`R  $$$ $$$"
     "   $$$&  $$$ $$$"
     "   $#*$  $$$ $$$"
     "   $  $  $$$ @$$"
     "   $  $  $$$ $$$"
     "   $  $  $$$ $$$"
     "   $  $  $B$ $$&."
     "   $  $  $D$ $$$$$muL."
     "   $  $  $Q$ $$$$$  `\"**mu.."
     "   $  $  $R$ $$$$$    k  `$$*t"
     "   $  @  $$$ $$$$$    k   $$!4"
     "   $ x$uu@B8u$NB@$uuuu6...$$X?"
     "   $ $(`RF`$`````R$ $$5`\"\"\"#R"
     "   $ $\" M$ $     $$ $$$      ?"
     "   $ $  ?$ $     T$ $$$      $"
     "   $ $F H$ $     M$ $$K      $  .."
     "   $ $L $$ $     $$ $$R.     \"d$$$$Ns."
     "   $ $~ $$ $     N$ $$X      .\"    \"%2h"
     "   $ 4k f  $     *$ $$&      R       \"iN\""
     "   $ $$ %uz!     tuuR$$:     Buu      ?`:\""
     "   $ $F          $??$8B      | '*Ned*$~L$\""
     "   $ $k          $'@$$$      |$.suu+!' !$\""
     "   $ ?N          $'$$@$      $*`      d:\""
     "   $ dL..........M.$&$$      5       d\"P"
     " ..$.^\"*I$RR*$C\"\"??77*?      \"nu...n*L*"
     "'$C\"R   ``\"\"!$*@#\"\"` .uor    bu8BUU+!`"
     "'*@m@.       *d\"     *$Rouxxd\"```$"
     "     R*@mu.           \"#$R *$    !"
     "     *%x. \"*L               $     %."
     "        \"N  `%.      ...u.d!` ..ue$$$o.."
     "         @    \".    $*\"\"\"\" .u$$$$$$$$$$$$beu..."
     "        8  .mL %  :R`     x$$$$$$$$$$$$$$$$$$$$$$$$$$WmeemeeWc"
     "       |$e!\" \"s:k 4      d$N\"`\"#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "       $$      \"N @      $?$    F$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "       $@       ^%Uu..   R#8buu$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                  ```\"\"*u$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                         #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                          \"5$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                            `*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                              ^#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                                 \"*$$$$$$$$$$$$$$$$$$$$$$$$$$>"
     "                                   `\"*$$$$$$$$$$$$$$$$$$$$$$$>"
     "                                       ^!$$$$$$$$$$$$$$$$$$$$>"
     "                                           `\"#+$$$$$$$$$$$$$$>"
     "                                                 \"\"**$$$$$$$$>"
     "                                                        ```\"\"")))

(define (usage)
  (print-gun)
  (print (string-append
	  "PHREAKSHOT \n"
	  "\n"
	  "brute [--cruise-control on] [--dict-file \"dict.txt\"] "
	  "[--pin-len 4] [--start 100] [--end 200] [--pause 3.8]"))
  (exit))

(define (parse-cli args)
  (when (not (null? args))
    (let ((arg (car args)))
      (if (= (remainder argc 2) 0)
	  (let ((param-name
		 (substring arg 2 (string-length arg)))
		(a 0))
	    (for-each (lambda (x)
			(when (equal? (symbol->string x) param-name)
			  (set! a (add1 a))))
		      expected-args)
	    (when (= a 0)
	      (usage))
	    (set! current-arg (string->symbol param-name)))
	  (cond ((eq? current-arg 'cruise-control)
		 (set! cruise-control (if (equal? arg "off")
					  #f
					  #t)))
		((eq? current-arg 'dict-file)
		 (set! dict-file-name arg))
		((eq? current-arg 'pin-len)
		 (set! pin-len (string->number arg)))
		((eq? current-arg 'start)
		 (set! range-start (string->number arg)))
		((eq? current-arg 'end)
		 (set! range-end (string->number arg)))
		((eq? current-arg 'pause)
		 (set! seconds-between-attempts (string->number arg)))))
      (set! argc (add1 argc))
      (parse-cli (cdr args)))))
(parse-cli (command-line-arguments))

