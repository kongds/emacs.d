(add-to-list 'load-path "~/.emacs.d/local")

;;---------------------------------------------
;;mutil-term
;;---------------------------------------------
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq system-uses-terminfo nil)

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
;;symon
;;-------------------------------------------
;;(symon-mode)

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

(provide 'init-local)
