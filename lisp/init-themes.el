(require 'doom-themes)
(require 'solaire-mode)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)



;; brighten buffers (that represent real files)
(add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)

;; ...if you use auto-revert-mode:
(add-hook 'after-revert-hook #'turn-on-solaire-mode)

;; You can do similar with the minibuffer when it is activated:
(add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

;; To enable solaire-mode unconditionally for certain modes:
(add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

;; Enable flashing mode-line on errors
;;(doom-themes-visual-bell-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable custom neotree theme
;;(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
;;
;;;;; Settings (defaults)
;;(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;      doom-themes-enable-italic t  ; if nil, italics is universally disabled
;;
;;      ;; doom-one specific settings
;;      doom-one-brighter-modeline nil
;;      doom-one-brighter-comments nil)
;;
;;;; Load the theme (doom-one, doom-dark, etc.)
;;(load-theme 'doom-one t)
;;
;;;;; OPTIONAL
;;;; brighter source buffers (that represent files)
;;(add-hook 'find-file-hook #'doom-buffer-mode-maybe)
;;;; ...if you use auto-revert-mode
;;(add-hook 'after-revert-hook #'doom-buffer-mode-maybe)
;;;; And you can brighten other buffers (unconditionally) with:
;;(add-hook 'ediff-prepare-buffer-hook #'doom-buffer-mode)
;;
;;;; brighter minibuffer when active
;;(add-hook 'minibuffer-setup-hook #'doom-brighten-minibuffer)
;;
;;;; Enable custom neotree theme
;;(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
;;
;;;; Enable nlinum line highlighting
;;(doom-themes-nlinum-config)   ; requires nlinum and hl-line-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(require-package 'color-theme-sanityinc-solarized)
;;(require-package 'color-theme-sanityinc-tomorrow)
;;
;;;; If you don't customize it, this is the theme you get.
;;(setq-default custom-enabled-themes '(sanityinc-solarized-light))
;;
;;;; Ensure that themes will be applied even if they have not been customized
;;(defun reapply-themes ()
;;  "Forcibly load the themes listed in `custom-enabled-themes'."
;;  (dolist (theme custom-enabled-themes)
;;    (unless (custom-theme-p theme)
;;      (load-theme theme)))
;;  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))
;;
;;(add-hook 'after-init-hook 'reapply-themes)
;;
;;
;;;;------------------------------------------------------------------------------
;;;; Toggle between light and dark
;;;;------------------------------------------------------------------------------
;;(defun light ()
;;  "Activate a light color theme."
;;  (interactive)
;;  (color-theme-sanityinc-solarized-light))
;;
;;(defun dark ()
;;  "Activate a dark color theme."
;;  (interactive)
;;  (color-theme-sanityinc-solarized-dark))


(provide 'init-themes)
