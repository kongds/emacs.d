(provide 'init-xcode)

(defvar xcode_base_applescript nil)
(defvar xcode_run_applescript nil)
(defvar xcode_stop_applescript nil)

(setq xcode_base_applescript
      (concat
       "tell application \"Xcode\"\r"
       "%s workspace document 1\r"
       "end tell\r"
       ))

(setq xcode_run_applescript
      (format xcode_base_applescript "run"))

(setq xcode_stop_applescript
      (format xcode_base_applescript "stop"))


(defun xcode-run ()
  "run xcode project use applescript."
  (interactive)
  (save-some-buffers)
  (do-applescript xcode_run_applescript))

(defun xcode-stop ()
  "stop xcode project use applescript."
  (interactive)
  (save-some-buffers)
  (do-applescript xcode_stop_applescript))

(defun xcode-build ()
  "build xcode project use xcodebuile and xpretty"
  (interactive)
  (save-some-buffers)
  (compile "cd ..;xcodebuild | xcpretty"))

(define-key objc-mode-map (kbd "s-r") 'xcode-run)
(define-key objc-mode-map (kbd "s-.") 'xcode-stop)

;;let .h can use object-c mode
(add-hook 'c-mode-hook (lambda ()
                         (cond
                          ((string-equal major-mode "objc-mode"))
                          ((not  (file-exists-p
                                  (replace-regexp-in-string "\.h" ".m"
                                                            (buffer-file-name)))))
                          ((search ".c" (buffer-file-name)))
                          (t (objc-mode)))))

;;use irony-mode to compile
;;too let object-c work fine use
;;;xcodebuild | xcpretty -r json-compilation-database -o compile_commands.json
;;to generate compile database let irony work fine on them
