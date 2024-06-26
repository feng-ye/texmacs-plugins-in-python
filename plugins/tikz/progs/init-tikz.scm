
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : init-tikz.scm
;; DESCRIPTION : Initialize TikZ plugin
;; COPYRIGHT   : (C) 2021 Darcy Shen
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-modules (dynamic session-edit) (dynamic program-edit))

(define (tikz-serialize lan t)
    (with u (pre-serialize lan t)
      (with s (texmacs->code (stree->tree u) "SourceCode")
        (string-append s "\n<EOF>\n"))))

(define (tikz-launcher)
  (if (url-exists? "$TEXMACS_HOME_PATH/plugins/tikz")
      (string-append (python-command) " \""
                     (getenv "TEXMACS_HOME_PATH")
                     "/plugins/tikz/bin/tikz.pex\"")
      (string-append (python-command) " \""
                     (getenv "TEXMACS_PATH")
                     "/plugins/tikz/bin/tikz.pex\"")))

(plugin-configure tikz
  (:require (python-command))
  (:require (url-exists-in-path? "pdflatex"))
  (:launch ,(tikz-launcher))
  (:serializer ,tikz-serialize)
  (:session "TikZ"))

