(require :stumpwm)

(in-package :stumpwm)

(setq *mouse-focus-policy*    :sloppy
      *float-window-modifier* :SUPER
      *startup-message* "Greetings, stranger.")

;; (set-font "CommitMono")
(set-module-dir "/usr/share/stupmwm/contrib/")
(init-load-path *module-dir*)

(setf *window-format* "%m%n%s%c")
(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))

(setf *time-modeline-string* "%a %b %e %k:%M")

(setq *mode-line-timeout* 4)

(when *initializing*
  (defvar *stumpwm-port* 4004)
  (require :swank)
  (swank-loader:init)
  (swank:create-server :port *stumpwm-port*
                       :style swank:*communication-style*
                       :dont-close t)
  (run-shell-command "sh ~/.fehbg")
  (when (equal (machine-instance) "zor")
    (run-shell-command "sh ~/.screenlayout/default.sh"))
  (dolist (s stumpwm:*screen-list*) 
    (enable-mode-line s (car (screen-heads s)) t)))

(which-key-mode)

(defcommand term (&optional program) ()
  (sb-thread:make-thread
   (lambda ()
     (run-shell-command (if program
                            (format nil "alacritty ~A" program)
                            "alacritty")))))

(defcommand blueberry () ()
  (sb-thread:make-thread
   (lambda ()
     (run-shell-command "blueberry"))))

(defcommand chromium () ()
  (sb-thread:make-thread
   (lambda ()
     (run-shell-command "chromium"))))

(define-key *root-map* (kbd "c") "term")
