(require 'rtags)
(require 'flycheck-rtags)
(require 'company-rtags)

(define-derived-mode qt-mode c++-mode "Qt"
  "this is mode for write qt project.
use rtags for company and flycheck (rtags is very good)
if the directory the file in have .pro file this file open with qt mode")

(add-hook 'c++-mode-hook (lambda ()
                           (cond
                            ((string-equal major-mode "qt-mode"))
                            ((string-empty-p
                              (shell-command-to-string
                               "find . -regex \".*\.pro$\"")))
                            ;;is *.pro existsing if is turn to qt
                            (t (qt-mode)))))

;;init rtags
(rtags-enable-standard-keybindings)
;; comment this out if you don't have or don't use helm
(setq rtags-use-helm t)
;; company completion setup
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)

;; use rtags flycheck mode -- clang warnings shown inline
(add-hook 'qt-mode-hook (lambda ()
                          "Configure flycheck-rtags for better experience."
                          (flycheck-select-checker 'rtags)
                          (setq-local flycheck-check-syntax-automatically nil)
                          (setq-local flycheck-highlighting-mode nil)))


(add-hook 'qt-mode-hook (lambda ()
                          "add company rtags"
                          (make-local-variable 'company-backends)
                          (push 'company-rtags company-backends)))


(provide 'init-qt)
