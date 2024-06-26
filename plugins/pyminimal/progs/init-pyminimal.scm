
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : init-pyminimal.scm
;; DESCRIPTION : Initialize the 'pyminimal' plugin
;; COPYRIGHT   : (C) 2019  Darcy Shen
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-modules (binary python3))

(define (python-launcher)
  (if (url-exists? "$TEXMACS_HOME_PATH/plugins/pyminimal")
      (string-append
        (url->system (find-binary-python3))
        " "
        (string-quote
         (url->string
          (string->url
           "$TEXMACS_HOME_PATH/plugins/pyminimal/bin/pyminimal.pex"))))
      (string-append
        (url->system (find-binary-python3))
        " "
        (string-quote
         (url->string
          (string->url
           "$TEXMACS_PATH/plugins/pyminimal/bin/pyminimal.pex"))))))

(plugin-configure pyminimal
  (:require (has-binary-python3?))
  (:launch ,(python-launcher))
  (:session "PyMinimal"))
