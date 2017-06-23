(require 'ace-jump-mode)
(require 'avy)

(require 'ace-isearch)

;;use ace-jump-char to replace avy-goto-char
(global-unset-key (kbd "C-;"))
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'ace-jump-line-mode)

;;ace isearch mode
(global-ace-isearch-mode +1)

(custom-set-variables
 '(ace-isearch-input-length 7)
 '(ace-isearch-jump-delay 0.25)
 '(ace-isearch-function 'avy-goto-char)
 '(ace-isearch-use-jump 'printing-char))

(define-key isearch-mode-map (kbd "C-;") 'ace-isearch-jump-during-isearch)

(provide 'init-ace)
