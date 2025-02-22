;;; ellis.el --- user Emacs config -*- lexical-binding: t -*-

;; Copyright (C) 2024

;; Author: Richard Westhaver <ellis@rwest.io>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This is an example of what you may want to add to your custom
;; config file. Feel free to rip.

;;; Code:
(require 'inbox)
(require 'sk)
(require 'sxp)
(require 'ulang)
(require 'graph)
(set-face-attribute 'default nil :height 172)

(defalias 'make #'compile)

(setq default-theme 'leuven-dark
      user-lab-directory (join-paths user-home-directory "lab")
      company-source-directory (join-paths user-home-directory "comp"))

(when (linux-p) (setq dired-listing-switches "-alsh"))

(defvar emacs-config-source (join-paths company-source-directory "core/emacs"))

;;;###autoload
(defun edit-emacs-config (&optional src)
  (interactive (list current-prefix-arg))
  (let ((file (if src 
                  (expand-file-name "default.el" emacs-config-source) 
                user-custom-file)))
    (find-file file)))

(keymap-set user-map "e c" #'edit-emacs-config)
(keymap-set emacs-lisp-mode-map "C-c C-l" #'load-file)
(keymap-set emacs-lisp-mode-map "C-c M-k" #'elisp-byte-compile-file)
(keymap-set user-map "v t" #'org-tags-view)

(require 'paredit)
(repeat-mode)

(keymap-set lisp-mode-shared-map "C-(" #'paredit-open-round)
(keymap-set lisp-mode-shared-map "M-(" #'paredit-wrap-sexp)
(keymap-set lisp-mode-shared-map "M-;" #'paredit-comment-dwim)
(keymap-set lisp-mode-shared-map "C-{" #'paredit-backward-barf-sexp)
(keymap-set lisp-mode-shared-map "C-}" #'paredit-forward-barf-sexp)
(keymap-set lisp-mode-shared-map "C-M-{" #'paredit-forward-slurp-sexp)
(keymap-set lisp-mode-shared-map "C-M-}" #'paredit-backward-slurp-sexp)

(defun remember-project ()
  (interactive)
  (project-remember-project (project-current))
  project--list)

(defun remember-lab-projects ()
  (interactive)
  (project-remember-projects-under user-lab-directory t))

(defun remember-comp-projects ()
  (interactive)
  (project-remember-projects-under company-source-directory t))

(keymap-global-set "C-<tab>" #'hippie-expand)
(keymap-set minibuffer-local-map "C-<tab>" #'hippie-expand)
(keymap-set ctl-x-x-map "p p" #'remember-project)
(keymap-set ctl-x-x-map "p l" #'remember-lab-projects)
(keymap-set ctl-x-x-map "p c" #'remember-comp-projects)

(add-hook 'prog-mode-hook #'skel-minor-mode)
(add-hook 'org-mode-hook #'skel-minor-mode)
;; (add-hook 'prog-mode-hook #'company-mode)

(add-hook 'notmuch-message-mode-hook #'turn-on-orgtbl)

(use-package ef-themes :ensure t)

(use-package markdown-mode :ensure t)

(use-package ol-notmuch :ensure t)

(use-package notmuch 
  :ensure t
  :init
  (setopt
   mail-user-agent 'message-user-agent
   smtpmail-smtp-server "smtp.gmail.com"
   message-send-mail-function 'message-smtpmail-send-it
   smtpmail-debug-info t
   message-default-mail-headers "Cc: \nBcc: \n"
   message-kill-buffer-on-exit t
   user-mail-address "richard.westhaver@gmail.com"
   user-full-name "Richard Westhaver"
   notmuch-hello-sections '(notmuch-hello-insert-saved-searches 
                            notmuch-hello-insert-search 
                            notmuch-hello-insert-recent-searches 
                            notmuch-hello-insert-alltags)
   notmuch-show-logo nil
   notmuch-search-oldest-first nil
   notmuch-hello-hide-tags '("kill")
   notmuch-saved-searches '((:name "unread" :query "tag:unread" :key "u")
                            (:name "inbox" :query "tag:inbox" :key "i")
                            (:name "new" :query "tag:new" :key "n")
                            (:name "drafts" :query "tag:draft" :key "d")
                            (:name "sent" :query "tag:sent" :key "e")
                            (:name "all" :query "*" :key "a")
                            (:name "todo" :query "tag:todo" :key "t")))
  :config
  ;;;###autoload
  (defun notmuch-exec-offlineimap ()
    "execute offlineimap command and tag new mail with notmuch"
    (interactive)
    (start-process-shell-command "offlineimap"
                                 "*offlineimap*"
                                 "offlineimap -o")
    (notmuch-refresh-all-buffers))

  (defun offlineimap-get-password (host port)
    (let* ((netrc (netrc-parse (expand-file-name "~/.netrc.gpg")))
           (hostentry (netrc-machine netrc host port port)))
      (when hostentry (netrc-get hostentry "password"))))

  (defun mark-as-read ()
    "mark message as read."
    (interactive)
    (notmuch-search-tag '("-new" "-unread" "-inbox")))

  (defun mark-as-todo ()
    "mark message as todo."
    (interactive)
    (mark-as-read)
    (notmuch-search-tag '("-new" "-unread" "-inbox" "+todo")))

  (defun mark-as-spam ()
    "mark message as spam."
    (interactive)
    (mark-as-read)
    (notmuch-search-tag (list "+spam")))

  (keymap-set user-map "e m" #'notmuch)
  (keymap-set user-map "e M" #'notmuch-exec-offlineimap)
  (keymap-set notmuch-search-mode-map "S" #'mark-as-spam)
  (keymap-set notmuch-search-mode-map "R" #'mark-as-read)
  (keymap-set notmuch-search-mode-map "T" #'mark-as-todo))

(use-package elfeed 
  :ensure t
  :custom
  elfeed-feeds 
  '(("http://threesixty360.wordpress.com/feed/" blog math)
    ("http://www.50ply.com/atom.xml" blog dev)
    ("http://blog.cryptographyengineering.com/feeds/posts/default" blog)
    ("http://abstrusegoose.com/feed.xml" comic)
    ("http://accidental-art.tumblr.com/rss" image math)
    ("http://researchcenter.paloaltonetworks.com/unit42/feed/" security)
    ("http://curiousprogrammer.wordpress.com/feed/" blog dev)
    ("http://feeds.feedburner.com/amazingsuperpowers" comic)
    ("http://amitp.blogspot.com/feeds/posts/default" blog dev)
    ("http://pages.cs.wisc.edu/~psilord/blog/rssfeed.rss" blog)
    ("http://www.anticscomic.com/?feed=rss2" comic)
    ("http://feeds.feedburner.com/blogspot/TPQSS" blog dev)
    ("http://techchrunch.com/feeds" tech news)
    ("https://rss.nytimes.com/services/xml/rss/nyt/Technology.xml" tech news)
    ("https://static.fsf.org/fsforg/rss/news.xml" tech news)
    ("https://feeds.npr.org/1001/rss.xml" news)
    ("https://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=wrss01&id=10000664" fin news)
    ("https://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=wrss01&id=19854910" tech news)
    ("https://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=wrss01&id=100003114" us news)
    ("http://arxiv.org/rss/cs" cs rnd)
    ("http://arxiv.org/rss/math" math rnd)
    ("http://arxiv.org/rss/q-fin" q-fin rnd)
    ("http://arxiv.org/rss/stat" stat rnd)
    ("http://arxiv.org/rss/econ" econ rnd)
    ;; John Wiegley
    ("http://newartisans.com/rss.xml" dev blog)
    ("https://www.reddit.com/r/listentothis/.rss" music reddit)
    ("https://www.ftc.gov/feeds/press-release-consumer-protection.xml" gov ftc)
    ("https://api2.fcc.gov/edocs/public/api/v1/rss/" gov fcc)
    )
  :init
  (defun yt-dl-it (url)
    "Downloads the URL in an async shell"
    (let ((default-directory user-stash-directory))
      (async-shell-command (format "yt-dlp %s" url))))

  (defun elfeed-youtube-dl (&optional use-generic-p)
    "Youtube-DL link"
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
               do (elfeed-untag entry 'unread)
               when (elfeed-entry-link entry)
               do (yt-dl-it it))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))
  :config
  (keymap-set elfeed-search-mode-map "d" 'elfeed-youtube-dl)
  (keymap-set user-map "e f" #'elfeed)
  (keymap-set user-map "e F" #'elfeed-update))

(use-package elfeed-tube
  :ensure t
  :after elfeed
  ;; :config
  ;; (elfeed-tube-setup)
  ;; (elfeed-tube-add-feeds '("detroit techno" "boiler room dj" "brad mehldau" "chris 'daddy' dave"))
  :bind (:map elfeed-show-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)
              :map elfeed-search-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)))

(use-package elfeed-tube-mpv
  :ensure t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(use-package org-mime :ensure t)

(use-package sh-script
  :hook (sh-mode . flymake-mode))

;;; Diary
(setq diary-list-include-blanks t)
;;; Org Config
;; (setq publish-dir "/ssh:rurik:/srv/http/compiler.company")

;; populate org-babel
;; TODO 2021-10-24: bqn, apl, k
(org-babel-do-load-languages 'org-babel-load-languages '((lua . t) (lilypond . t)))

;; timeline
(use-package org-timeline
  :load-path user-emacs-lib-directory
  :hook (org-agenda-finalize . org-timeline-insert-timeline)
  :init
  (setq
   org-timeline-insert-before-text "›"
   org-timeline-beginning-of-day-hour 8
   org-timeline-default-duration 30
   org-timeline-keep-elapsed 2
   org-timeline-start-hour 8
   org-timeline-show-text-in-blocks t
   org-timeline-prepend nil))

;;; IRC
(setq erc-format-nick-function 'erc-format-@nick)

(defun start-erc ()
  "Connect to IRC."
  (interactive)
  (erc-tls :server "irc.libera.chat" :port 6697
           :client-certificate '("/mnt/y/data/private/krypt/libera.pem"))
  (setq erc-autojoin-channels-alist '(("irc.libera.chat" "#emacs")
                                      ("irc.libera.chat" "#linux")
                                      ("irc.libera.chat" "#rust")
                                      ("irc.libera.chat" "#btrfs")
                                      ("irc.libera.chat" "#lisp")
                                      ("irc.libera.chat" "#sbcl")
                                      ("irc.oftc.net" "#llvm"))))
;;; Tags
;;;###autoload
(defun refresh-tags ()
  "Refresh TAGS database in `user-emacs-directory'."
  (interactive)
  (let ((default-directory user-emacs-directory))
    (async-shell-command 
     "etags ./*.el \\
./lib/*.el \\
~/comp/core/emacs/*.el \\
~/comp/core/emacs/lib/*.el \\
-o TAGS")))

(unless (string-equal "hyde"  system-name)
  (add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
  (add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)
  (nerd-icons-completion-mode)
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; strangerdanger
;; (setq slime-enable-evaluate-in-emacs t)

(defun org-word-count (beg end
                           &optional count-latex-macro-args?
                           count-footnotes?)
  "Report the number of words in the Org mode buffer or selected region.
Ignores:
- comments
- tables
- source code blocks (#+BEGIN_SRC ... #+END_SRC, and inline blocks)
- hyperlinks (but does count words in hyperlink descriptions)
- tags, priorities, and TODO keywords in headers
- sections tagged as 'not for export'.

The text of footnote definitions is ignored, unless the optional argument
COUNT-FOOTNOTES? is non-nil.

If the optional argument COUNT-LATEX-MACRO-ARGS? is non-nil, the word count
includes LaTeX macro arguments (the material between {curly braces}).
Otherwise, and by default, every LaTeX macro counts as 1 word regardless
of its arguments."
  (interactive "r")
  (unless mark-active
    (setf beg (point-min)
          end (point-max)))
  (let ((wc 0)
        (latex-macro-regexp "\\\\[A-Za-z]+\\(\\[[^]]*\\]\\|\\){\\([^}]*\\)}"))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond
         ;; Ignore comments.
         ((or (org-at-comment-p) (org-at-table-p))
          nil)
         ;; Ignore hyperlinks. But if link has a description, count
         ;; the words within the description.
         ((looking-at org-bracket-link-analytic-regexp)
          (when (match-string-no-properties 5)
            (let ((desc (match-string-no-properties 5)))
              (save-match-data
                (cl-incf wc (length (remove "" (org-split-string
                                                desc "\\W")))))))
          (goto-char (match-end 0)))
         ((looking-at org-any-link-re)
          (goto-char (match-end 0)))
         ;; Ignore source code blocks.
         ((org-between-regexps-p "^#\\+BEGIN_SRC\\W" "^#\\+END_SRC\\W")
          nil)
         ;; Ignore inline source blocks, counting them as 1 word.
         ((save-excursion
            (backward-char)
            (looking-at org-babel-inline-src-block-regexp))
          (goto-char (match-end 0))
          (setf wc (+ 2 wc)))
         ;; Count latex macros as 1 word, ignoring their arguments.
         ((save-excursion
            (backward-char)
            (looking-at latex-macro-regexp))
          (goto-char (if count-latex-macro-args?
                         (match-beginning 2)
                       (match-end 0)))
          (setf wc (+ 2 wc)))
         ;; Ignore footnotes.
         ((and (not count-footnotes?)
               (or (org-footnote-at-definition-p)
                   (org-footnote-at-reference-p)))
          nil)
         (t
          (let ((contexts (org-context)))
            (cond
             ;; Ignore tags and TODO keywords, etc.
             ((or (assoc :todo-keyword contexts)
                  (assoc :priority contexts)
                  (assoc :keyword contexts)
                  (assoc :checkbox contexts))
              nil)
             ;; Ignore sections marked with tags that are
             ;; excluded from export.
             ((assoc :tags contexts)
              (if (intersection (org-get-tags-at) org-export-exclude-tags
                                :test 'equal)
                  (org-forward-same-level 1)
                nil))
             (t
              (cl-incf wc))))))
        (re-search-forward "\\w+\\W*")))
    (format "%d words in %s." wc
            (if mark-active "region" "buffer"))))

(defun org-check-misformatted-subtree ()
  "Check misformatted entries in the current buffer."
  (interactive)
  (show-all)
  (org-map-entries
   (lambda ()
     (when (and (move-beginning-of-line 2)
                (not (looking-at org-heading-regexp)))
       (if (or (and (org-get-scheduled-time (point))
                    (not (looking-at (concat "^.*" org-scheduled-regexp))))
               (and (org-get-deadline-time (point))
                    (not (looking-at (concat "^.*" org-deadline-regexp)))))
           (when (y-or-n-p "Fix this subtree? ")
             (message "Call the function again when you're done fixing this subtree.")
             (recursive-edit))
         (message "All subtrees checked."))))))

(defun org-sort-list-by-checkbox-type ()
  "Sort list items according to Checkbox state."
  (interactive)
  (org-sort-list
   nil ?f
   (lambda ()
     (if (looking-at org-list-full-item-re)
         (cdr (assoc (match-string 3)
                     '(("[X]" . 1) ("[-]" . 2) ("[ ]" . 3) (nil . 4))))
       4))))

(defun org-time-string-to-seconds (s)
  "Convert a string HH:MM:SS to a number of seconds."
  (cond
   ((and (stringp s)
         (string-match "\\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\)" s))
    (let ((hour (string-to-number (match-string 1 s)))
          (min (string-to-number (match-string 2 s)))
          (sec (string-to-number (match-string 3 s))))
      (+ (* hour 3600) (* min 60) sec)))
   ((and (stringp s)
         (string-match "\\([0-9]+\\):\\([0-9]+\\)" s))
    (let ((min (string-to-number (match-string 1 s)))
          (sec (string-to-number (match-string 2 s))))
      (+ (* min 60) sec)))
   ((stringp s) (string-to-number s))
   (t s)))

(defun org-time-seconds-to-string (secs)
  "Convert a number of seconds to a time string."
  (cond ((>= secs 3600) (format-seconds "%h:%.2m:%.2s" secs))
        ((>= secs 60) (format-seconds "%m:%.2s" secs))
        (t (format-seconds "%s" secs))))

(defmacro with-time (time-output-p &rest exprs)
  "Evaluate an org-table formula, converting all fields that look
like time data to integer seconds.  If TIME-OUTPUT-P then return
the result as a time value."
  (list
   (if time-output-p 'org-time-seconds-to-string 'identity)
   (cons 'progn
         (mapcar
          (lambda (expr)
            `,(cons (car expr)
                    (mapcar
                     (lambda (el)
                       (if (listp el)
                           (list 'with-time nil el)
                         (org-time-string-to-seconds el)))
                     (cdr expr))))
          `,@exprs))))

(defun org-hex-strip-lead (str)
  (if (and (> (length str) 2) (string= (substring str 0 2) "0x"))
      (substring str 2) str))

(defun org-hex-to-hex (int)
  (format "0x%x" int))

(defun org-hex-to-dec (str)
  (cond
   ((and (stringp str)
         (string-match "\\([0-9a-f]+\\)" (setf str (org-hex-strip-lead str))))
    (let ((out 0))
      (mapc
       (lambda (ch)
         (setf out (+ (* out 16)
                      (if (and (>= ch 48) (<= ch 57)) (- ch 48) (- ch 87)))))
       (coerce (match-string 1 str) 'list))
      out))
   ((stringp str) (string-to-number str))
   (t str)))

(defmacro with-hex (hex-output-p &rest exprs)
  "Evaluate an org-table formula, converting all fields that look
    like hexadecimal to decimal integers.  If HEX-OUTPUT-P then
    return the result as a hex value."
  (list
   (if hex-output-p 'org-hex-to-hex 'identity)
   (cons 'progn
         (mapcar
          (lambda (expr)
            `,(cons (car expr)
                    (mapcar (lambda (el)
                              (if (listp el)
                                  (list 'with-hex nil el)
                                (org-hex-to-dec el)))
                            (cdr expr))))
          `,@exprs))))

(require 'mm-url) ; to include mm-url-decode-entities-string

(cl-defun get-first-url (&optional (match (rx bol "http" (optional "s") "://")))
  "Return URL in clipboard, or first URL in the `kill-ring' matching MATCH."
  (cl-loop for item in (cons (current-kill 0) kill-ring)
           when (and item (string-match-p match item))
           return item))

(defun get-html-title-from-url (url)
  "Return content in <title> tag."
  (interactive (list (get-first-url)))
  (let (x1 x2 (download-buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer download-buffer)
      (beginning-of-buffer)
      (setq x1 (search-forward "<title>"))
      (search-forward "</title>")
      (setq x2 (search-backward "<"))
      (mm-url-decode-entities-string (buffer-substring-no-properties x1 x2)))))

(defun org-insert-link-with-title (url)
  "Insert org link where default description is set to html title."
  (interactive (list (get-first-url match)))
  (let ((title (get-html-title-from-url url)))
    (org-insert-link nil url title)))

(defun org-insert-so-link (url)
  (interactive (list (get-first-url (rx bol "https://" (* anychar) "stackoverflow.com"))))
  (let ((title (get-html-title-from-url url)))
    (org-insert-link nil url title)))

(defun org-remove-empty-propert-drawers ()
  "*Remove all empty property drawers in current file."
  (interactive)
  (unless (eq major-mode 'org-mode)
    (error "You need to turn on Org mode for this function."))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward ":PROPERTIES:" nil t)
      (save-excursion
        (org-remove-empty-drawer-at "PROPERTIES" (match-beginning 0))))))

(defun check-for-clock-out-note ()
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (let ((tags (org-get-tags)))
      (and tags (message "tags: %s " tags)
           (when (member "clocknote" tags)
             (org-add-note))))))

(add-hook 'org-clock-out-hook 'check-for-clock-out-note)

(defun org-list-files (dirs ext)
  "Function to create list of org files in multiple subdirectories.
This can be called to generate a list of files for
org-agenda-files or org-refile-targets.

DIRS is a list of directories.

EXT is a list of the extensions of files to be included."
  (let ((dirs (if (listp dirs)
                  dirs
                (list dirs)))
        (ext (if (listp ext)
                 ext
               (list ext)))
        files)
    (mapc
     (lambda (x)
       (mapc
        (lambda (y)
          (setq files
                (append files
                        (file-expand-wildcards
                         (concat (file-name-as-directory x) "*" y)))))
        ext))
     dirs)
    (mapc
     (lambda (x)
       (when (or (string-match "/.#" x)
                 (string-match "#$" x))
         (setq files (delete x files))))
     files)
    files))

(defvar org-agenda-directories (list (join-paths company-source-directory "org/plan")
                                     (join-paths company-source-directory "org/plan/tasks"))
  "List of directories containing org files.")

(defvar org-agenda-extensions '(".org")
  "List of extensions of agenda files")

;; (setq org-agenda-default-appointment-duration nil)
(setq org-agenda-span 5)
(defun org-set-agenda-files ()
  (interactive)
  (setq org-agenda-files
        (cons org-inbox-file
              (cl-remove-if (lambda (x) (string= "readme.org" (file-name-nondirectory x)))
                            (org-list-files
                             org-agenda-directories
                             org-agenda-extensions)))))

(defun org-set-refile-targets ()
  (interactive)
  (setq org-refile-targets
        `((,(cl-remove-if 
             (lambda (x) (string= "readme.org" (file-name-nondirectory x)))
             (org-list-files
              (list company-org-directory org-directory
                    (join-paths company-org-directory "graph/**")
                    (join-paths company-org-directory "plan/**")
                    (join-paths company-org-directory "docs/**")
                    (join-paths company-org-directory "blog/**")
                    (join-paths company-org-directory "meta/**"))
               org-agenda-extensions))
           . (:maxlevel . 8))
          (nil . (:level . 3)))))

(with-eval-after-load 'org
  (org-set-agenda-files)
  (org-set-refile-targets))

;; org-agenda-auto-update
(defvar org-agenda-update-interval 300)
(defvar org-agenda-update-timer nil)
(defvar org-agenda-update-idle t)

(defun org-agenda-update ()
  (org-agenda-redo-all t))

(defun org-agenda-auto-update ()
  (when org-agenda-update-timer
    (setq org-agenda-update-timer
          (cancel-timer org-agenda-update-timer)))
  (setq org-agenda-update-timer
        (if org-agenda-update-idle
            (run-with-idle-timer org-agenda-update-interval t 'org-agenda-update)
          ;; when we refresh the org-agenda buffer, also reset the timer
          (add-hook 'org-agenda-finalize-hook 'org-agenda-auto-update)
          (run-with-timer org-agenda-update-interval org-agenda-update-interval 'org-agenda-update))))

(with-eval-after-load 'org-agenda
  (org-agenda-auto-update))

;;; Skel Config
(use-package skel
  :requires skel
  :load-path user-emacs-lib-directory
  :custom
  tempo-interactive t  
  auto-insert 'no-modify
  auto-insert-query nil)

(use-package skt
  :requires (skel skt)
  :load-path user-emacs-lib-directory
  :custom
  skt-enable-tempo-elements t
  skt-delete-duplicate-marks t
  :config
  (defvar skt-default-version "0.1.0")
  (keymap-set skt-minor-mode-map "b" #'tempo-backward-mark)
  (keymap-set skt-minor-mode-map "f" #'tempo-forward-mark)
  (keymap-set skt-minor-mode-map "SPC" #'tempo-complete-tag)
  (keymap-set skt-minor-mode-map "t" #'skt-add-tag)

  (defvar skt-skeleton-path-function #'abbreviate-file-name
    "Function to be called when expanding file-header skeletons. Useful to
rebind locally inside a project or module, where you want to delete some
prefix or replace it.")

  (defun skt-buffer-path (&optional function)
    (let ((path (or buffer-file-name (format "%s.lisp" (gensym "scratch-")))))
      (funcall (or function skt-skeleton-path-function) path)))

  (defun skt-skelfile-path ()
    (if (string= (file-name-nondirectory buffer-file-name) "skelfile")
        "skelfile"
      (skt-buffer-path)))

  ;; functions
  (skt-define-function capture (:abbrev "capture" :tag t) org-capture)
  (skt-define-function agenda (:abbrev "agenda" :tag t) org-agenda)
  (skt-define-function mjump (:abbrev "mjump" :tag t) bookmark-jump)
  (skt-define-function bjump (:abbrev "bjump" :tag t) ibuffer-jump)
  (skt-define-function rjump (:abbrev "rjump" :tag t)
    (lambda () (jump-to-register (read-char "register: "))))
  (skt-define-function pjump (:abbrev "pjump" :tag t) (lambda () (project-switch-project default-directory)))

  ;; templates
  (skt-define-template readme (:mode org-mode :tag t)
    "#+title: " (p "title: ") n
    "#+description: " (p "description: ") n
    "#+author: " user-full-name n
    "#+email:" user-mail-address n
    "#+setupfile: clean.theme" n
    "#+export_file_name: index" n>
    p n> n>
    ":info:" n>
    "+ version :: " skt-default-version n
    ":end:" n>)

  (skt-define-template clean.theme (:mode org-mode :tag t)
    "#+setupfile: " (join-paths company-cdn-url "org/clean.theme"))

  ;; TODO 2024-06-04: 
  ;; (skt-define-template defsystem (:mode lisp-mode :tag t :abbrev "defsystem"))
  ;; (skt-define-template defpackage (:mode lisp-mode :tag t :abbrev "defpackage"))
  ;; (skt-define-template defpkg (:mode lisp-mode :tag t :abbrev "defpkg"))

  (skt-define-template defmacro (:abbrev "(defmacro" :tag t :mode lisp-mode)
    "(defmacro " (p "Name: ") " (" (p "Args: ") ")" > n> r ")")

  (skt-define-template defun (:abbrev "(defun" :tag t :mode lisp-mode)
    "(defun " (p "Name: ") " (" (p "Args: ") ")" > n> r ")")

  (skt-define-template defvar (:abbrev "(defvar" :tag t :mode lisp-mode)
    > "(defvar " > r ")")

  ;; skeletons
  (skt-define-skeleton head (:abbrev "head" :mode lisp-mode)
    "description: "
    ";;; " (skt-buffer-path 'file-name-nondirectory) " --- " str \n \n ";; " _ \n \n ";;; Code:" \n >)

  (skt-define-skeleton head (:abbrev "head" :mode skel-mode)
    "description: "
    ";;; " (skt-skelfile-path) " --- " str " -*- mode: skel; -*-" \n _)

  (skt-define-skeleton head (:abbrev "head" :mode org-mode)
    "title: "
    "#+title: " str \n
    "#+author: " (skeleton-read "author: ") \n
    "#+description: " (skeleton-read "description: ") \n
    "#+setupfile: clean.theme" \n > _)

  (skt-define-skeleton head (:abbrev "head" :mode rust-mode)
    "description: "
    "//! " (skt-buffer-path 'file-name-nondirectory) " --- " str \n \n "// " _ \n \n "//! Code: " \n >)

  (skt-define-skeleton system-head (:abbrev "system-head" :mode lisp-mode)
    "system-name: "
    ";;; " (skt-buffer-path) " --- "
    '(setq v1 (file-name-base (skt-buffer-path))) (capitalize v1)
    " Sytem Definitions" \n
    > "(defsystem :" v1 \n
    > ":depends-on (:std :log)" \n
    > ":components ((:file \"pkg\")" _ "))")

  (skt-define-skeleton pkg-head (:abbrev "pkg-head" :mode lisp-mode)
    "ignored"
    ";;; " (skt-buffer-path 'file-name-nondirectory) " --- "
    '(setq v1 (skeleton-read "name: ")) v1 " Package Definitions" \n
    > "(defpkg :" v1 \n
    > ":use (:std :log))" \n \n
    > "(in-package :" v1 ")" \n >)
  
  (skt-define-skeleton crate-head (:abbrev "crate-head" :mode conf-toml-mode)
    "ignored"
    "### " (skt-buffer-path 'file-name-nondirectory) " --- " 
    '(setq v1 (skeleton-read "name: ")) v1 " Cargo Manifest" \n >
    "[package]" \n
    "name = \"" v1 "\"" \n
    "version = \"" skt-default-version "\"" \n
    "[dependencies]" \n >)

  (skt-define-skeleton local-vars
      (:tag t :abbrev "local-vars"
            :docstring "Insert a local variables section.  Use current comment syntax if any.")
    (completing-read "Mode: " obarray
		     (lambda (symbol)
		       (if (commandp symbol)
			   (string-match "-mode$" (symbol-name symbol))))
		     t)
    '(save-excursion
       (if (re-search-forward page-delimiter nil t)
	   (error "Not on last page")))
    comment-start "Local Variables:" comment-end \n
    comment-start "mode: " str
    & -5 | '(kill-line 0) & -1 | comment-end \n
    ( (completing-read (format "Variable, %s: " skeleton-subprompt)
		       obarray
		       (lambda (symbol)
		         (or (eq symbol 'eval)
			     (custom-variable-p symbol)))
		       t)
      comment-start str ": "
      (read-from-minibuffer "Expression: " nil read-expression-map nil
			    'read-expression-history) | _
      comment-end \n)
    resume:
    comment-start "End:" comment-end \n)

  ;; autoinsert
  (skt-register-auto-insert "skelfile" #'skt-template-skel-head)
  (skt-register-auto-insert "readme.org" #'skt-template-org-readme)
  (skt-register-auto-insert "Cargo.toml" #'skt-template-conf-toml-crate-head)
  (skt-register-auto-insert "pkg.lisp" #'skt-template-lisp-pkg-head)
  (skt-register-auto-insert ".*[.]asd" #'skt-template-lisp-system-head)
  (skt-register-auto-insert ".*[.]lisp" #'skt-template-lisp-head)
  (skt-register-auto-insert ".*[.].rs" #'skt-template-rust-head)
  (auto-insert-mode t)
  ;; (keymap-set skel-minor-mode-map "C-<return>" 'company-tempo)
  )

;;; ical2org
;; go install github.com/rjhorniii/ical2org@latest
(defun ical2org (file)
  "Convert ics FILE to an org-mode heading."
  (interactive "ffile: ")
  (shell-command (format "ical2org %s -a %s" file org-inbox-file)))

;;; glossary
;; (with-eval-after-load 'org-glossary
;;   (setq org-glossary-collection-root (join-paths company-source-directory "org/meta/"))
;;   (cl-pushnew '("Terms" . glossary) org-glossary-headings)
;;   (cl-pushnew '("Acronyms" . acronym) org-glossary-headings))

;;; Calc
(setq calc-highlight-selections-with-faces t)
(cl-pushnew '(lisp-mode "#| " "|#
") calc-embedded-open-close-mode-alist)
(cl-pushnew '(emacs-lisp-mode ";; " "
") calc-embedded-open-close-mode-alist)

(defun calc-eval-region (arg beg end)
  "Calculate the region and display the result in the echo area.
With prefix ARG non-nil, insert the result at the end of region."
  (interactive "P\nr")
  (let* ((expr (buffer-substring-no-properties beg end))
         (result (calc-eval expr)))
    (if (null arg)
        (message "%s = %s" expr result)
      (goto-char end)
      (save-excursion
        (insert result)))))

(defun calc-embedded-formula-to-stack ()
  (interactive)
  (save-excursion
    (save-match-data
      (calc-embedded-find-bounds)))
  (let ((eq-str (buffer-substring calc-embed-top calc-embed-bot)))
    (calc-eval eq-str 'push)))

;; (add-hook 'skel-minor-mode-hook 'skel-dir-local-get-variables)

(provide 'ellis)
;; ellis.el ends here
