(require :stumpwm)

(in-package :stumpwm)

(stumpwm:set-prefix-key (kbd "s-SPC"))

(ignore-errors
 (ql:quickload '(:std :core :prelude :user :swank)))

(defcommand quickload (system)
  ((:rest "System: "))
  "Load a system with QL:QUICKLOAD"
  (ql:quickload system))

(defcommand load-std () ()
  (ql:quickload :std))

(defcommand load-prelude () ()
  (ql:quickload :prelude))

(defcommand load-core () ()
  (ql:quickload :core))

(defcommand load-user () ()
  (ql:quickload :user)
  (in-package :user))

(setq *mouse-focus-policy*    :sloppy
      *float-window-modifier* :SUPER
      *startup-message* "Greetings, stranger.")

(set-module-dir "~/.stumpwm.d/contrib")
(init-load-path *module-dir*)

(ql:quickload :clx-truetype)
(load-module "ttf-fonts")
(xft:cache-fonts)
(set-font (make-instance 'xft:font
            :family "Mononoki Nerd Font"
            :subfamily "Regular"
            :size 12))

(load-module "swm-golden-ratio")
(unless swm-golden-ratio:*golden-ratio-on*
  (swm-golden-ratio:toggle-golden-ratio))

(load-module "screenshot")
(load-module "cpu")
(load-module "hostname")
(load-module "mpd")
(load-module "mem")
(ql:quickload '(:cl-diskspace :cl-mount-info))
(load-module "disk")
(setq *mode-line-highlight-template* "«~A»")
(setf *screen-mode-line-format* (list "[^B%n^b] %W^> %C | %M | %l | %D | %h | %d"))

(ql:quickload :xml-emitter)
(ql:quickload :dbus)

(set-fg-color "#ffffff")
(set-bg-color "#000000")
(set-border-color "#7E5D90")
(set-focus-color "#170F14")
(set-unfocus-color "#232731")
(set-win-bg-color "#22272F")
(set-float-focus-color "#8ED3A1")
(set-float-unfocus-color "#232731")

(setf *mode-line-background-color* "#161613")
(setf *mode-line-foreground-color* "#FFFFFF")
(setf *mode-line-border-color* "#28394c")
(setf *mode-line-position* :bottom)

(setf *colors* (list "#010101"      ; 0 black
                     "#BF616A"      ; 1 red
                     "#A3BE8C"      ; 2 green
                     "#EBCB8B"      ; 3 yellow
                     "#5E81AC"      ; 4 blue
                     "#9D5AAF"      ; 5 magenta
                     "#8FBCBB"      ; 6 cyan
                     "#FEFEFE"))    ; 7 white

(setf *window-format* "%m%n%s%c")
(set-normal-gravity :center)
(set-maxsize-gravity :center)
(set-transient-gravity :center)
(setf *time-modeline-string* "%F %H:%M")
(setf *group-format* "%t")
(setq *mode-line-timeout* 4)

(which-key-mode)

(when *initializing*
  (grename "*MAIN*")
  (gnewbg "*ORG*")
  (gnewbg "*MEDIA*")
  (gnewbg "*SCRATCH*")
  (run-shell-command "sh ~/.fehbg")
  (when (equal (machine-instance) "zor")
    (run-shell-command "sh ~/.screenlayout/default.sh"))
  (dolist (h (screen-heads (current-screen)))
    (enable-mode-line (current-screen) h t)))

(clear-window-placement-rules)

(define-frame-preference "*MAIN*" (nil t t :class "Tiling"))
(define-frame-preference "*ORG*" (nil t t :class "Tiling"))
(define-frame-preference "*MEDIA*" (nil t t :class "Floating"))
(define-frame-preference "*SCRATCH*" (nil t t :class "Tiling"))

(setf *dynamic-group-master-split-ratio* 1/2)

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

(defcommand firefox () ()
  "Run or raise Firefox."
  (sb-thread:make-thread
   (lambda () (run-or-raise "firefox" '(:class "Firefox") t nil))))

(defcommand chromium () ()
  (sb-thread:make-thread
   (lambda ()
     (run-or-raise "chromium" '(:class "Chromium") t nil))))

(defcommand emacsclient () ()
  (run-shell-command "emacsclient -c -a="))

(defcommand homer () ()
  (run-shell-command "homer"))

(defcommand skel () ()
  (run-shell-command "skel"))

(define-key *root-map* (kbd "t") "term")
(define-key *root-map* (kbd "e") "emacsclient")
(define-key *root-map* (kbd "C-e") "emacs")
(define-key *root-map* (kbd "s-w") "chromium")
