(require :stumpwm)

(in-package :stumpwm)

(stumpwm:set-prefix-key (kbd "s-SPC"))

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; load our packages
;; (ql:quickload '(:std :log :cli :dat :net :io)) ;; :swank
;; (shadowing-import '(message) :std)

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

(defcommand load-swank () ()
  (ql:quickload :swank))

(setq *mouse-focus-policy*    :click
      *float-window-modifier* :meta
      *startup-message* "Greetings, stranger.")

(set-module-dir "~/.stumpwm.d/contrib")
(init-load-path *module-dir*)

(ql:quickload :clx-truetype)
(load-module "ttf-fonts")
(xft:cache-fonts)

(set-font (make-instance 'xft:font
            :family "Mononoki Nerd Font Propo"
            :subfamily "Regular"
            :size 18))

;; (load-module "swm-golden-ratio")
(load-module "screenshot")
(load-module "cpu")
(load-module "hostname")
(load-module "mpd")
(load-module "mem")
(load-module "net")
(load-module "command-history")
;; (ql:quickload '(:cl-diskspace :cl-mount-info))
;; (load-module "disk") ;; conflicts with io/disk
(setq *mode-line-highlight-template* "<~A>")
;; TODO 2024-12-26: %D
(setq *screen-mode-line-format* (list "[^B%n^b] %W^> %C | %M %l %h %d"))

(ql:quickload :xml-emitter)
(ql:quickload :dbus)

(load-module "clipboard-history")

(define-key *root-map* (kbd "C-y") "show-clipboard-history")
;; start the polling timer process
(clipboard-history:start-clipboard-manager)

(set-fg-color "#ffffff")
(set-bg-color "#000000")
(set-border-color "#7E5D90")
(set-focus-color "#170F14")
(set-unfocus-color "#232731")
(set-win-bg-color "#22272F")
(set-float-focus-color "#8ED3A1")
(set-float-unfocus-color "#232731")

(setq *mode-line-background-color* "#161613")
(setq *mode-line-foreground-color* "#FFFFFF")
(setq *mode-line-border-color* "#28394c")
(setq *mode-line-position* :bottom)

(setq *colors* (list "#010101"      ; 0 black
                     "#BF616A"      ; 1 red
                     "#A3BE8C"      ; 2 green
                     "#EBCB8B"      ; 3 yellow
                     "#5E81AC"      ; 4 blue
                     "#9D5AAF"      ; 5 magenta
                     "#8FBCBB"      ; 6 cyan
                     "#FEFEFE"))    ; 7 white

(setq *window-format* "%m%n%s%c")
(set-normal-gravity :center)
(set-maxsize-gravity :center)
(set-transient-gravity :center)
(setq *time-modeline-string* "%F %H:%M")
(setq *group-format* "%t")
(setq *mode-line-timeout* 4)

(which-key-mode)

;; (clear-window-placement-rules)

;; (setf *dynamic-group-master-split-ratio* 1/2)
;; (define-frame-preference "scratch" (:float nil t))

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

(defcommand mpk () ()
  (run-shell-command "mpk"))

(defcommand rofi () ()
  (run-shell-command "rofi -show drun"))

(defcommand arandr () ()
  (run-shell-command "arandr"))

(defcommand gparted () ()
  (run-shell-command "sudo gparted"))

(define-key *root-map* (kbd "b") "colon1 exec chromium https://")
(define-key *root-map* (kbd "C-s") "colon1 exec alacritty -e ssh ")
;; Lock screen (requires extra/xlockmore)
(define-key *root-map* (kbd "C-l") "exec xlock")
(define-key *root-map* (kbd "C-f") "fullscreen")
(in-package :stumpwm)
(unbind "F1")
(unbind "F2")
(unbind "F3")
(unbind "F4")
(unbind "F5")
(unbind "F6")
(unbind "F7")
(unbind "F8")
(unbind "F9")
(unbind "F10")
(unbind "F11")

(define-key *root-map* (kbd "t") "term")
(define-key *root-map* (kbd "e") "emacsclient")
(define-key *root-map* (kbd "C-e") "emacs")
(define-key *root-map* (kbd "s-w") "chromium")
(define-key *root-map* (kbd "d") "rofi")
(define-key *root-map* (kbd "M-1") "gselect 1")
(define-key *root-map* (kbd "M-2") "gselect 2")
(define-key *root-map* (kbd "M-3") "gselect 3")
(define-key *root-map* (kbd "M-4") "gselect 4")
(define-key *root-map* (kbd "M-5") "gselect 5")
(define-key *root-map* (kbd "M-6") "gselect 6")
(define-key *root-map* (kbd "M-7") "gselect 7")
(define-key *root-map* (kbd "M-8") "gselect 8")
(define-key *root-map* (kbd "M-9") "gselect 9")
(define-key *root-map* (kbd "M-0") "gselect 10")

(dolist (h (screen-heads (current-screen)))
  (enable-mode-line (current-screen) h t))

(grename "default")
(gnewbg "org")
(gnewbg "web")
(gnewbg "scratch")

(when (equal (machine-instance) "zor")
  (run-shell-command "sh ~/.screenlayout/default.sh"))
(run-shell-command "sh ~/.fehbg")
