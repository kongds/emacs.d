(add-to-list 'load-path "~/.emacs.d/local")

;;---------------------------------------------
;;mutil-term
;;---------------------------------------------
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq system-uses-terminfo nil)
(define-key term-raw-map (kbd "C-k") (lambda ()
                                       (interactive)
                                       (kill-line)
                                       (term-send-raw)))
(add-hook 'term-mode-hook '(lambda ()  (whole-line-or-region-local-mode -1)))

;;---------------------------------------------
;;dwrite
;;--------------------------------------------
(require 'dwrite)

;;----------------------------------------------
;;key
;;---------------------------------------------
(require 'mod_key)

;;-------------------------------------------
;;speedbar
;;-------------------------------------------
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

;;-------------------------------------------
;;matlab
;;-------------------------------------------
(setq matlab-shell-command "/Applications/MATLAB_R2016a.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))

;;-------------------------------------------
;;quick window open(make c easy to use)
;;-------------------------------------------
(ac-config-default)

;;-------------------------------------------
;;grep quickly
;;-------------------------------------------
(defun royokong_grep (string)
  "grep --color -nH -e $what_you_input"
  (interactive "sgrep:")
  (grep (concat "grep --color -nH -e " string " *"))
  )

(defun royokong_grep_r (string)
  "grep --color -nH -e $what_you_input"
  (interactive "sgrep_r:")
  (grep (concat "grep --color -nHr -e " string " *"))
  )

;;-------------------------------------------
;;close projectile
;;-------------------------------------------
(projectile-global-mode -1)

;;-------------------------------------------
;;initial-scratch-message
;;-------------------------------------------
(setq initial-scratch-message (concat ";; Sorry for my existence --" user-login-name "\n\n"))

;;-------------------------------------------
;;xcdoc search
;;-------------------------------------------
(require 'helm-xcdoc)
(setq helm-xcdoc-command-path "/Applications/Xcode.app/Contents/Developer/usr/bin/docsetutil")
(setq helm-xcdoc-document-path "/Applications/Xcode.app/Contents/Developer/Documentation/DocSets/com.apple.adc.documentation.docset")

(setq auto-mode-alist (delete '("\\.m$" . matlab-mode) auto-mode-alist))

;;-------------------------------------------
;;python  search
;;-------------------------------------------
(elpy-enable)

;;-------------------------------------------
;;goto file
;;-------------------------------------------
(defun royokong_local ()
  "goto local file"
  (interactive)
  (find-file "~/.emacs.d/lisp/init-local.el")
  )

;;-------------------------------------------
;;quick open
;;-------------------------------------------
(require 'quickOpen)

;;-------------------------------------------
;;stop use auto-complete
;;-------------------------------------------
(global-auto-complete-mode -1)

;;-------------------------------------------
;;opencl mode
;;-------------------------------------------
(add-to-list 'load-path "/Users/royokong/.emacs.d/elpa/opencl-mode-20160220.909/opencl-mode.el")
(require 'opencl-mode)
(add-to-list 'auto-mode-alist '("\\.cl\\'" . opencl-mode))

;;-------------------------------------------
;;remove bell
;;-------------------------------------------
(setq ring-bell-function #'ignore)

;;-------------------------------------------
;;fullscreen
;;-------------------------------------------
(require 'frame)
(defun toggle-frame-fullscreen ()
  "Toggle fullscreen state of selected frame.
Make selected frame fullscreen or restore its previous size if it
is already fullscreen.

Before making the frame fullscreen remember the current value of
the frame's `fullscreen' parameter in the `fullscreen-restore'
parameter of the frame.  That value is used to restore the
frame's fullscreen state when toggling fullscreen the next time.

Note that with some window managers you may have to set
`frame-resize-pixelwise' to non-nil in order to make a frame
appear truly fullscreen.  In addition, you may have to set
`x-frame-normalize-before-maximize' in order to enable
transitions from one fullscreen state to another.

See also `toggle-frame-maximized'."
  (interactive)
  (let ((fullscreen (frame-parameter nil 'fullscreen)))
    (if (memq fullscreen '(fullscreen fullboth))
        (let ((fullscreen-restore (frame-parameter nil 'fullscreen-restore)))
          (if (memq fullscreen-restore '(maximized fullheight fullwidth))
              (set-frame-parameter nil 'fullscreen fullscreen-restore)
            (set-frame-parameter nil 'fullscreen nil)))
      (modify-frame-parameters
       nil `((fullscreen . fullscreen) (fullscreen-restore . ,fullscreen))))))


;;-------------------------------------------
;;check init
;;-------------------------------------------
(defun test-startup ()
  (interactive)
  (async-shell-command "cd ~/.emacs.d;./test-startup.sh"))

;;-------------------------------------------
;;rewrite y-or-n-p (let enter can use as y)
;;-------------------------------------------
(fset 'y-or-n-p
      (byte-compile  (lambda (prompt)
                       "Ask user a \"y or n\" question.
Return t if answer is \"y\" and nil if it is \"n\".
PROMPT is the string to display to ask the question.  It should
end in a space; `y-or-n-p' adds \"(y or n) \" to it.

No confirmation of the answer is requested; a single character is
enough.  SPC also means yes, and DEL means no.

To be precise, this function translates user input into responses
by consulting the bindings in `query-replace-map'; see the
documentation of that variable for more information.  In this
case, the useful bindings are `act', `skip', `recenter',
`scroll-up', `scroll-down', and `quit'.
An `act' response means yes, and a `skip' response means no.
A `quit' response means to invoke `keyboard-quit'.
If the user enters `recenter', `scroll-up', or `scroll-down'
responses, perform the requested window recentering or scrolling
and ask again.

Under a windowing system a dialog box will be used if `last-nonmenu-event'
is nil and `use-dialog-box' is non-nil."
                       (let ((answer 'recenter)
                             (padded (lambda (prompt &optional dialog)
                                       (let ((l (length prompt)))
                                         (concat prompt
                                                 (if (or (zerop l) (eq ?\s (aref prompt (1- l))))
                                                     "" " ")
                                                 (if dialog "" "(y or n) "))))))
                         (cond
                          (noninteractive
                           (setq prompt (funcall padded prompt))
                           (let ((temp-prompt prompt))
                             (while (not (memq answer '(act skip)))
                               (let ((str (read-string temp-prompt)))
                                 (cond ((member str '("y" "Y")) (setq answer 'act))
                                       ((member str '("n" "N")) (setq answer 'skip))
                                       (t (setq temp-prompt (concat "Please answer y or n.  "
                                                                    prompt))))))))
                          ((and (display-popup-menus-p)
                                last-input-event ; not during startup
                                (listp last-nonmenu-event)
                                use-dialog-box)
                           (setq prompt (funcall padded prompt t)
                                 answer (x-popup-dialog t `(,prompt ("Yes" . act) ("No" . skip)))))
                          (t
                           (setq prompt (funcall padded prompt))
                           (while
                               (let* ((scroll-actions '(recenter scroll-up scroll-down
                                                                 scroll-other-window scroll-other-window-down))
                                      (key
                                       (let ((cursor-in-echo-area t))
                                         (when minibuffer-auto-raise
                                           (raise-frame (window-frame (minibuffer-window))))
                                         (read-key (propertize (if (memq answer scroll-actions)
                                                                   prompt
                                                                 (concat "Please answer y or n.  "
                                                                         prompt))
                                                               'face 'minibuffer-prompt)))))
                                 ;;let ret can work
                                 (setq answer (if (equal key 13)
                                                  'act
                                                (lookup-key query-replace-map (vector key) t)))
                                 (cond
                                  ((memq answer '(skip act)) nil)
                                  ((eq answer 'recenter)
                                   (recenter) t)
                                  ((eq answer 'scroll-up)
                                   (ignore-errors (scroll-up-command)) t)
                                  ((eq answer 'scroll-down)
                                   (ignore-errors (scroll-down-command)) t)
                                  ((eq answer 'scroll-other-window)
                                   (ignore-errors (scroll-other-window)) t)
                                  ((eq answer 'scroll-other-window-down)
                                   (ignore-errors (scroll-other-window-down)) t)
                                  ((or (memq answer '(exit-prefix quit)) (eq key ?\e))
                                   (signal 'quit nil) t)
                                  (t t)))
                             (ding)
                             (discard-input))))
                         (let ((ret (eq answer 'act)))
                           (unless noninteractive
                             (message "%s%c" prompt (if ret ?y ?n)))
                           ret)))))

;;-------------------------------------------
;;ask you if you want to kill emacs
;;-------------------------------------------
(global-set-key (kbd "C-x C-c")
                (lambda () (interactive)
                  (if (y-or-n-p "Do you want to quit? ")
                      (save-buffers-kill-terminal))))


;;-------------------------------------------
;;persistent-scratch
;;-------------------------------------------
(require 'persistent-scratch)
(persistent-scratch-setup-default)

;;-------------------------------------------
;;doc mode
;;-------------------------------------------
(require 'doc-view)
(require 'image)
(define-key doc-view-mode-map (kbd "h") 'image-backward-hscroll)
(define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
(define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)
(define-key doc-view-mode-map (kbd "l") 'image-forward-hscroll)

(provide 'init-local)
