(require 'spaceline-config)
;;(spaceline-spacemacs-theme)
;;(spaceline-helm-mode)

(use-package spaceline-all-the-icons 
  :after spaceline
  :config (spaceline-all-the-icons-theme))
(spaceline-all-the-icons--setup-anzu) ;; Enable anzu searching
(spaceline-all-the-icons--setup-package-updates) ;; Enable package update indicator
(spaceline-all-the-icons--setup-git-ahead)       ;; Enable # of commits ahead of upstream in git
(spaceline-all-the-icons--setup-paradox)         ;; Enable Paradox mode line
(spaceline-all-the-icons--setup-neotree)         ;; Enable Neotree mode line

