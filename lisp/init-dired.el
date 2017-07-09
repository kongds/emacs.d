(require-package 'dired+)
(require-package 'dired-sort)
(require 'dired-rainbow)
(require 'all-the-icons-dired)

(setq-default diredp-hide-details-initially-flag nil
              dired-dwim-target t)

;; Prefer g-prefixed coreutils version of standard utilities when available
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))




(when (maybe-require-package 'diff-hl)
  (after-load 'dired
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)))

(defconst my-dired-media-files-extensions
  '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
  "Media files.")

(dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
(dired-rainbow-define media "#ce5c00" my-dired-media-files-extensions)
(dired-rainbow-define el     "#ff00ff" ("el"))

(dired-rainbow-define-chmod executable-unix "Green" "-.*x.*")

(define-key dired-mode-map (kbd "s-o") (lambda () (interactive) (dired-do-shell-command
                                                            "open" nil
                                                            (dired-get-marked-files t current-prefix-arg))))

(after-load 'dired
  (require 'dired+)
  (require 'dired-sort)
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-recursive-deletes 'top)
  ;;(define-key dired-mode-map [mouse-2] 'dired-find-file)
  (setq dired-mode-hook nil)
  (add-hook 'dired-mode-hook
            (lambda () (guide-key/add-local-guide-key-sequence "%")))
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (add-hook 'dired-mode-hook 'diredp--set-up-font-locking)
  )

(after-load 'dired+
  (setq diredp-dir-name dired-directory-face))


(global-set-key (kbd "C-c p") '(lambda () (interactive)
                                 (kill-new (substring  (pwd) 10 nil))))

(provide 'init-dired)
