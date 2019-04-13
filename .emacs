;; package --- Summary:
;; --------------------

(require 'package)

;;; Repositories:
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

; Apparently needed for the package auto-complete (why?)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-enable-at-startup nil)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; CONFIGURACION BASICA
;; --------------------------------------------------

;; Apaga el sonidito.
(setq visible-bell t)

;; Show opening, closing parens
(show-paren-mode)

;; Insert matching delimiters.
(electric-pair-mode)

;; Line numbers
;;; If `display-line-numbers-mode' is available (only in Emacs 26),
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; --------------------------------------------------

;; Una forma de instalar paquetes.

(defvar myPackages
  '(evil
    ycmd
    company-ycmd
    flycheck-ycmd
    clang-format
    modern-cpp-font-lock
    helm
    yasnippet
    powerline
    nyan-mode
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Evil-mode
(require 'evil)
(evil-mode t)

;; yMCd
(require 'ycmd)
(add-hook 'after-init-hook #'global-ycmd-mode)

(set-variable 'ycmd-server-command '("python" "/usr/share/ycmd/ycmd"))


;;Completion
(defun ycmd-setup-completion-at-point-function ()
  "Setup `completion-at-point-functions' for `ycmd-mode'."
  (add-hook 'completion-at-point-functions
            #'ycmd-complete-at-point nil :local))

(add-hook 'ycmd-mode-hook #'ycmd-setup-completion-at-point-function)

;;Company
(require 'company-ycmd)
(company-ycmd-setup)

;;flycheck
(require 'flycheck-ycmd)
(flycheck-ycmd-setup)

(global-flycheck-mode)

;;global config
(set-variable 'ycmd-global-config "~/global_config.py")

(set-variable 'ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))

(set-variable 'ycmd-global-config "~/.ycm_extra_conf.py")

;;YCMD KEY BINDINGS
(global-set-key (kbd "C-c y") 'ycmd-goto) ; Ctrl+c t

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;               PYTHON               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Elpy
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (add-to-list 'python-shell-completion-native-disabled-interpreters "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt")
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1))))

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Formatting
(use-package py-autopep8
  :ensure t
  :hook (python-mode-hook . py-autopep8-enable-on-save))

(define-key elpy-mode-map (kbd "C-c C-f") 'py-autopep8)
  


;; Docstrings
(use-package sphinx-doc
  :ensure t
  :hook (python-mode . sphinx-doc-mode))

(use-package python-docstring
  :ensure t
  :config (setq python-docstring-sentence-end-double-space nil)
  :hook (python-mode . python-docstring-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;          C family languages         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clang-format can be triggered using C-c C-f
;; Create clang-format file using google style
;; clang-format -style=google -dump-config > .clang-format
(require 'clang-format)
(add-hook
     'c++-mode-hook
      (lambda ()
      (local-set-key (kbd "C-c C-f") #'clang-format-region)))
;; Format style.
(setq clang-format-style-option "Google")

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

;; Helm
(require 'helm-config)

;;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;; YAsnippets
(require 'yasnippet)
(yas-global-mode 1)
   

;;; Barrita kawaii
;;(require 'powerline)
;;(powerline-center-evil-theme)

;;; Themes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (nyan-mode elpy geiser yasnippet-snippets yasnippet use-package sml-mode smart-mode-line-powerline-theme smart-mode-line-atom-one-dark-theme modern-cpp-font-lock magit helm flycheck-ycmd evil-visual-mark-mode company-ycmd clang-format))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;;(smart-mode-line-enable)
    ;;(sml/setup)
`(mode-line ((t (:background "#11ADAD" :foreground "black" :box (:line-width 3 :color "grey30")))))
)

;; Nyan-cat!!!!!!!!!!!!!
(nyan-mode t)
(nyan-start-animation)
(nyan-toggle-wavy-trail)

(provide '.emacs)

;;; .emacs ends here
