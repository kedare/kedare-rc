;;
;; Mathieu Poussin
;; mathieu.poussin@netyxia.net
;;

;; Packages Loading
(require 'package)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
                package-archives )
  (push '("melpa" . "http://melpa.milkbox.net/packages/")
                package-archives)

(package-initialize)

(require 'evil)
  (evil-mode 1)

(require 'helm-config)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)    
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-yascroll-bar-mode 1)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(add-hook 'ruby-mode-hook 'robe-mode)

(add-hook 'term-mode-hook
    (lambda ()
      (setq term-buffer-maximum-size 10000))
      (setq show-trailing-whitespace nil)
    )

(sml/setup)
(sml/apply-theme 'dark)

(require 'scss-mode)

;; ERC 
(require 'erc)
(require 'erc-list)
(setq erc-user-full-name "Mathieu Poussin")
(setq erc-email-userid "mpo@ntx.so")

;;(setq erc-input-line-position -2)

(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/.irclogs/")
(setq erc-save-buffer-on-part t)

(defcustom pushover-token nil
  "pushover application token")

(defcustom pushover-user-key nil
  "pushover user-key")

(defun pushover-notify (title msg)
  (let ((url-request-method "POST")
	(url-request-data (concat "token=" pushover-token
				  "&user=" pushover-user-key
				  "&title=" title
				  "&message=" msg)))
    (url-retrieve "https://api.pushover.net/1/messages.json" 'pushover-kill-url-buffer)))

(defun pushover-kill-url-buffer (status)
  "Kill the buffer returned by `url-retrieve'."
    (kill-buffer (current-buffer)))

;; Notify my when someone mentions my nick.
(defun erc-global-notify (matched-type nick msg)
  (interactive)
  (when (eq matched-type 'current-nick)
    (pushover-notify "ERC Notification" (concat nick ": " message))
   ))
(add-hook 'erc-text-matched-hook 'erc-global-notify)

;; END OF ERC

;; Smooth Scrolling

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

(add-to-list 'erc-mode-hook (lambda ()
  (set (make-local-variable 'scroll-conservatively) 1)))

;; End of smooth scrolling

(global-set-key (kbd "C-x C-z") 'next-multiframe-window)

(require 'ido)
(ido-mode t)

;;(global-set-key (kbd "C-x C-b") 'ibuffer)
;;    (autoload 'ibuffer "ibuffer" "List buffers." t)

(global-set-key (kbd "C-x C-b") 'helm-buffers-list) 

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(org-indent-mode)

;; My settings
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(column-number-mode 1)
(line-number-mode 1)
(setq c-basic-offset 2)
(load-library "paren")
(show-paren-mode 1)
(transient-mark-mode t)
(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(setq sentence-end-double-space nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq calendar-week-start-day 1)
(load-theme 'solarized-dark)
