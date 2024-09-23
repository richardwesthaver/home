;;; stumpwm-mode.el --- special lisp mode for evaluating code into running stumpwm -*- lexical-binding: t -*-

;; Copyright (C) 2007  Shawn Betts

;; Maintainer: Shawn Betts
;; Keywords: comm, lisp, tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; load this file, set stumpwm-shell-program to point to stumpish and
;; run M-x stumpwm-mode in your stumpwm lisp files. Now, you can
;; easily eval code into a running stumpwm using the regular bindings.

;;; Code:

(defvar stumpwm-shell-program "stumpish"
  "program name, including path if needed, for the stumpish program.")

;;;###autoload 
(define-minor-mode stumpwm-mode
    "add some bindings to eval code into a running stumpwm using stumpish."
  :global nil
  :lighter " StumpWM"
  :keymap (let ((m (make-sparse-keymap)))
            (define-key m (kbd "C-M-x") 'stumpwm-eval-defun)
            (define-key m (kbd "C-x C-e") 'stumpwm-eval-last-sexp)
            m))

(defun stumpwm-eval-region (start end)
  (interactive "r")
  (let ((s (buffer-substring-no-properties start end)))
    (message "%s"
             (with-temp-buffer
               (call-process stumpwm-shell-program nil (current-buffer) nil
                             "eval"
                             s)
               (delete-char -1)
               (buffer-string)))))

(defun stumpwm-eval-defun ()
  (interactive)
  (save-excursion
    (end-of-defun)
    (skip-chars-backward " \t\n\r\f")
    (let ((end (point)))
      (beginning-of-defun)
      (stumpwm-eval-region (point) end))))

(defun stumpwm-eval-last-sexp ()
  (interactive)
  (stumpwm-eval-region (save-excursion (backward-sexp) (point)) (point)))

(defun stumpwm-connect ()
  "Start slime and connect to the lisp image that is running the
  swank server.  Must have (require :swank) 
  (swank:create-server) in your .stumpwmrc"
  (interactive)
  (slime-connect "127.0.0.1"  4005)
  (with-current-buffer (current-buffer)
    (rename-buffer "*sbcl-stumpwm-repl*")
    (slime-eval '(in-package :stumpwm))))

(defun stumpwm-disconnect ()
  "Disconnects from the swank server currently open."
  (with-current-buffer 
      (switch-to-buffer "*sbcl-stumpwm-repl*")
    (slime-disconnect)))
;;Lifted (with stylistic changes) from http://www.emacswiki.org/emacs/EmacsAsDaemon#toc9
(defun modified-buffers-exist () 
  "This function will check to see if there are any buffers
that have been modified.  It will return true if there are
and nil otherwise. Buffers that have buffer-offer-save set to
nil are ignored."
  (let (modified-found)
    (dolist (buffer (buffer-list))
      (when (and (buffer-live-p buffer)
                 (buffer-modified-p buffer)
                 (not (buffer-base-buffer buffer))
                 (or
                  (buffer-file-name buffer)
                  (progn
                    (set-buffer buffer)
                    (and buffer-offer-save (> (buffer-size) 0)))))
        (setq modified-found t)))
    modified-found))

(defun stumpwm-daemon-shutdown-emacs (&optional display)
  " This is a function that can bu used to shutdown save buffers and 
shutdown the emacs daemon. It should be called using 
emacsclient -e \'(stumpwm-daemon-shutdown-emacs)\'.  This function will
check to see if there are any modified buffers or active clients
or frame.  If so an x window will be opened and the user will
be prompted."

  (let (new-frame modified-buffers active-clients-or-frames)
    ; Check if there are modified buffers or active clients or frames.
    (setq modified-buffers (modified-buffers-exist))
    (setq active-clients-or-frames ( or (> (length server-clients) 1)
                                        (> (length (frame-list)) 1)))  
    ; Create a new frame if prompts are needed.
    (when (or modified-buffers active-clients-or-frames)
      ;; (when (not (eq window-system 'x))
      ;;   (message "Initializing x windows system.")
      ;;   (x-initialize-window-system))
      (when (not display) (setq display (getenv "DISPLAY")))
      (message "Opening frame on display: %s" display)
      (select-frame (make-frame-on-display display '((window-system . x)))))
    ; Save the current frame.  
    (setq new-frame (selected-frame))
    ; When displaying the number of clients and frames: 
    ; subtract 1 from the clients for this client.
    ; subtract 2 from the frames this frame (that we just created) and the default frame.
    (when ( or (not active-clients-or-frames)
               (yes-or-no-p (format "There are currently %d clients and %d frames. Exit anyway?" 
                                    (- (length server-clients) 1) (- (length (frame-list)) 2)))) 
      ; If the user quits during the save dialog then don't exit emacs.
      ; Still close the terminal though.
      (let((inhibit-quit t))
             ; Save buffers
        (with-local-quit
          (save-some-buffers)) 
        (if quit-flag
          (setq quit-flag nil)  
          ; Kill all remaining clients
          (progn
            (dolist (client server-clients)
              (server-delete-client client))
                 ; Exit emacs
            (kill-emacs)))))
    ; If we made a frame then kill it.
    (when (or modified-buffers active-clients-or-frames) (delete-frame new-frame))))

(provide 'stumpwm-mode)
;;; stumpwm-mode.el ends here
