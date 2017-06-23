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

;;;;;;;;;;;;;;;;;;;;;;
;;irony-init
;;;;;;;;;;;;;;;;;;;;;;
;;hooks
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

;;company
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(require 'company-irony-c-headers)
;; Load with `irony-mode` as a grouped backend
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;;flycheck
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(provide 'init-cc)
