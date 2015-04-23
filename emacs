;; Security
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(require 'erc)


  (defun zone-choose (pgm)
    "Choose a PGM to run for `zone'."
    (interactive
     (list
      (completing-read
       "Program: "
       (mapcar 'symbol-name zone-programs))))
    (let ((zone-programs (list (intern pgm))))
      (zone)))


(require 'ido)
(ido-mode t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
    (autoload 'ibuffer "ibuffer" "List buffers." t)

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
