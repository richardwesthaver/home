(require :stumpwm)
;; (require :swank)
(in-package :stumpwm)
;; (swank-loader:init)

(setq *mouse-focus-policy*    :sloppy
      *float-window-modifier* :SUPER
      *startup-message* "Greetings, stranger.")

;; (set-font "CommitMono")
(set-module-dir "/usr/share/stupmwm/contrib/")
(init-load-path *module-dir*)

;;(setf *window-format* "%m%n%s%c")
(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))

(setf *time-modeline-string* "%a %b %e %k:%M")

(setq *mode-line-timeout* 4)

(enable-mode-line (current-screen) (current-head) t)

(when *initializing*
  (run-shell-command "sh ~/.fehbg"))

(which-key-mode)

(defcommand term (&optional program) ()
  (sb-thread:make-thread
   (lambda ()
     (run-shell-command (if program
                            (format nil "alacritty ~A" program)
                            "alacritty")))))

(define-key *root-map* (kbd "c") "term")
