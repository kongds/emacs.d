(setq-default grep-highlight-matches t
              grep-scroll-output t)

(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(when (executable-find "ag")
  (require-package 'helm)
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'helm-do-grep-ag))


(provide 'init-grep)
