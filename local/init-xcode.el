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


(defun xcode_run ()
  "run xcode project use applescript."
  (interactive)
  (save-some-buffers)
  (do-applescript xcode_run_applescript))

(defun xcode_stop ()
  "stop xcode project use applescript."
  (interactive)
  (save-some-buffers)
  (do-applescript xcode_stop_applescript))

(add-hook 'objc-mode-hook
          (lambda () (local-set-key (kbd "C-c C-r") 'xcode_run)))

(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-objc-clang-setup))


;; Sorry for my existence --royokong


(defvar osx-base-path
  "/Applications/Xcode.app/Contents/Developer/Platforms/")

(if (equal system-type 'darwin)
                                        ; Only the then clause needs a progn, else part doesn't need it.
    (progn
      ;; Forgot what this was for..think some os x issues.
      (setenv "LC_CTYPE" "UTF-8")
      (setq
       flycheck-make-executable "/usr/local/bin/make"
       company-clang-executable
       (concat "/Applications/Xcode.app/Contents/Developer/"
               "Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++")
       company-clang-arguments
       `(
         "-isysroot"
                                        ; If coding for iOS
         ,(concat osx-base-path
                  "iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator10.2.sdk")
                                        ; If coding for OS X
         ;;,(concat osx-base-path
         ;;         "MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk")
         "-I" "/usr/include/c++/4.2.1"
         "-I" "/usr/local/lib/ocaml/")
       flycheck-c/c++-clang-executable
       (concat "/Applications/Xcode.app/Contents/Developer/"
               "Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++")))
  (set-face-attribute 'default nil :height 110)
  (setq company-clang-executable "armv7-apple-darwin11-clang"
        company-clang-arguments '("-std=c++11"
                                  "-isysroot"
                                  "/home/gar/.nix-profile/iPhoneOS.sdk"
                                  "-I/usr/local/lib/ocaml/")))


;;(defvar-local need-load-backends (list 'company-clang 'company-capf
;;                                       'company-c-headers 'company-jedi))
;;(loop for i in need-load-backends
;;      if (loop for j in company-backends
;;               with out = t
;;               if (equal j i)
;;               do (setq out nil)
;;               finally return out)
;;      do (cons company-backends i))

(require 'company-clang)
;;(setq company-backends '(company-clang))

(add-hook 'objc-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 '(company-capf company-c-headers company-clang company-dabbrev))
            (message "hook")
            (local-unset-key (kbd "M-/"))
            (local-set-key (kbd "M-/") 'company-clang)
            ))

(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
