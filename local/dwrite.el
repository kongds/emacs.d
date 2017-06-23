(define-derived-mode diary-mode fundamental-mode "diary-mode"
  (define-key diary-mode-map (kbd "C-c C-s") 'diary-save))
(defun diary-save ()
  (interactive)
  (write-file "/Users/royokong/Desktop/data")
  (shell-command-to-string "cd /Users/royokong/Desktop;dwrite")
  )

(defun dwrite ()
  (interactive)
  (switch-to-buffer "diary")
  (insert (concat (current-time-string) "\n"))
  (diary-mode)
  (message "SHUT UP!!! write down"))

(provide 'dwrite)