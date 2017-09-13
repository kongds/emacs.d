;; Sorry for my existence --royokong

(defun one-line (ch p)
  (interactive (list (read-char "ch: ")
                     (+ (point) 1)))
  (if (eq p (point-at-eol))
      (message "not found")
    (if (char-equal ch (aref  (buffer-substring-no-properties
                               p (+ p 1)) 0))
        (goto-char p)
      (one-line ch (+ p 1)))))


(global-set-3key (kbd "C-t") 'one-line)


