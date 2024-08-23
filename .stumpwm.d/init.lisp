(require :stumpwm)

(in-package :stumpwm)

(stumpwm:set-prefix-key (kbd "s-SPC"))

(defcommand load-std () ()
  (ql:quickload :std))

(defcommand load-prelude () ()
  (ql:quickload :prelude))

(defcommand load-core () ()
  (ql:quickload :core))

(defcommand load-user () ()
  (ql:quickload :user))

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

(load-module "stumptray")

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
(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(set-normal-gravity :center)
(set-maxsize-gravity :center)
(set-transient-gravity :center)
(setf *time-modeline-string* "%a %b %e %k:%M")

(setq *mode-line-timeout* 4)(
which-key-mode)

(when *initializing*
  (run-shell-command "sh ~/.fehbg")
  (when (equal (machine-instance) "zor")
    (run-shell-command "sh ~/.screenlayout/default.sh"))
  (dolist (h (screen-heads (current-screen)))
    (enable-mode-line (current-screen) h t)))

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

(defcommand emacsclient () ()
  (run-shell-command "emacsclient -c -a="))

(define-key *root-map* (kbd "c") "term")
(define-key *root-map* (kbd "e") "emacsclient")
(define-key *root-map* (kbd "C-e") "emacs")
(define-key *root-map* (kbd "s-w") "chromium")
