(define-derived-mode quick-open-mode fundamental-mode "quick-open-mode"
  (define-key quick-open-mode-map (kbd "<RET>") 'quick-open-open-at-point)
  )

(defvar *quick-open-histroy* nil)



(defun replace-all (str1 str2)
  (beginning-of-buffer)
  (replace-regexp str1 str2)
  )

(defun quick-open-open-at-point ()
  (interactive)
  (let ((file-path
         (buffer-substring-no-properties
          (point-at-bol) (point-at-eol))))
    (kill-buffer (buffer-name))
    (find-file file-path)
    )

  )

(defun quick-open (fileName)
  "quick open file use mdfind(only in osx)"
  (interactive
   (let ((*fileName* (read-string "file:" nil '*quick-open-histroy*)))
     (list *fileName*)))

  (get-buffer-create fileName)
  (switch-to-buffer fileName)

  (shell-command-on-region (point) (point) (format "mdfind -name %s" fileName)
                           (buffer-name))

  (replace-all (format ".*[^/]%s.*\n" fileName) "")
  (replace-all (format ".*%s.+\n" fileName) "")
  (replace-all "\/Users\/royokong" "~")

  (quick-open-mode)
  (read-only-mode)

  (end-of-buffer)

  (if (= (line-number-at-pos) 2)
      (progn
        (previous-line)
        (quick-open-open-at-point)
        )
    (beginning-of-buffer)
    )
  )

(provide 'quickOpen)
