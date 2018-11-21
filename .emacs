;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;;yMCd
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(compile-command "g++ -Wall -Wextra -Werror -o ")
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(package-selected-packages
   (quote
    (company-ycmd flycheck-ycmd ycmd modern-cpp-font-lock clang-format sml-mode)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; clang-format can be triggered using C-c C-f
;; Create clang-format file using google style
;; clang-format -style=google -dump-config > .clang-format
(require 'clang-format)
(global-set-key (kbd "C-c C-f") 'clang-format-region)

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)


