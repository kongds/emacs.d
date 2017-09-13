(global-set-key [(control \0)] 'toggle-frame-fullscreen)

;;add
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;window nubmer and window do or undo
(global-set-key (kbd "C-x w") 'winner-undo)

;;replace
(global-set-key (kbd "M-s s") 'anzu-query-replace)
(global-set-key (kbd "M-s r") 'anzu-query-replace-regexp)

;;keyboard-escape-quit
(global-unset-key (kbd "ESC ESC ESC"))

;; don not pop up the font
(global-unset-key (kbd "s-t"))

;;dictionary
(global-set-key (kbd "C-c d") 'bing-dict-brief)

;;unset ido-list-directory
(global-unset-key (kbd "C-x C-d"))

;;unset set_fill_colum
(global-unset-key (kbd "C-x f"))

;;grep
(global-set-key (kbd "C-x g") 'royokong_grep)
;;(global-set-key (kbd "C-x C-g") 'royokong_grep_r)

;;unset magit-status
(global-unset-key (kbd "C-x g"))

;;compile
(global-set-key (kbd "C-,") 'compile)

;;remove mac set
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;;quick open
(global-set-key (kbd "C-c o") 'quick-open)

;;macro repeat
(global-set-key (kbd "C-.") 'kmacro-end-and-call-macro)

;;mac key
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "s-w") 'delete-frame)
(global-set-key (kbd "s-h") 'iconify-frame)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-n") 'make-frame)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)
(global-set-key (kbd "s-i") 'multi-term)

;;mu4e
(global-set-key (kbd "C-c m") 'mu4e)

(provide 'mod_key)
