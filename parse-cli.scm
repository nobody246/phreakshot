(define expected-args '(cruise-control dict-file pin-len start end pause))

(define (print-gun)
  (for-each
   (lambda (x)
     (print x))
   `("         .__. "
     "         |  |------------------------------------------."
     "         |  |                 CCc    T                 |"
     "         |  |           A    C    T  T  T              |" 
     "         |  |   C C    AA   C      TTTTT       $$$$$$$ |"
     "         |  | C       AAAA  C    C   T   U  U  $       |"
     "         |  |   C C  A    A   C C    T  U   U   $$$$$$$ "
     "         |  |                        T   U U           $"
     "         |  | $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ "
     "        .____."
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
	  "PHREAKSHOT v1.0 ©2018 a.se8seven (_a_t) gm...com\n"
	  "illegal use not permitted, not responsible for any damage under any\n"
	  "circumstances.\n\n\n\n"
	  "brute [--cruise-control on] [--dict-file dict.txt] "
	  "[--pin-len 4] [--start 9999] [--end 0000] [--pause 3.8]"))
  (exit))

(define (parse-cli args)
  (when (not (null? args))
    (let ((arg (car args)))
      (if (= (remainder argc 2) 0)
	  (let ((param-name
		 (substring arg 2 (string-length arg)))
		(found #f))
	    (for-each (lambda (x)
			(when (equal? (symbol->string x) param-name)
			  (set! found #t)))
		      expected-args)
	    (when (not found)
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

