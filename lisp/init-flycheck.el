(when (maybe-require-package 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode))
  )


(provide 'init-flycheck)
