(require 'cc-mode)

(defun compile-cc (isC++)
  "run the cpp at first line comment "
  (let ((compile-file (buffer-name))
        (out-file     (car  (split-string (buffer-name) "\\."))))
    (save-buffer)
    (compile
     (if  (eq (length (shell-command-to-string "ls | grep Make")) 0)
         (concat (if isC++ "g++ " "gcc ")
                 "-o "
                 out-file
                 " "
                 compile-file
                 ";./"
                 out-file
                 )
       "make -k"))))

(define-key c++-mode-map (kbd "s-r") '(lambda () (interactive) (compile-cc t)))
(define-key c-mode-map   (kbd "s-r") '(lambda () (interactive) (compile-cc nil)))

(provide 'init-cc)

(shell-command "ls | grep make")
(if  (eq (length (shell-command-to-string "ls | grep Make")) 0))
