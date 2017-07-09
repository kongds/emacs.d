                                        ;(require-package 'ycmd)
(require-package 'company-ycmd)

(require 'ycmd)
;;下面那句要取消注释
;;(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'ycmd-mode)
;;路径就是你自己的ycmd的路径
(set-variable 'ycmd-server-command 
              '("python" "/Users/royokong/Desktop/ycmd/ycmd/"))
;;(set-variable 'ycmd-global-config "/Users/royokong/.emacs.d/global_conf.py")
(set-variable 'ycmd-extra-conf-whitelist '("/Users/royokong/Desktop/useless/qt/print/*"))
;;(set-variable 'ycmd-extra-conf-whitelist '("/Users/royokong/Desktop//qt/hello_qt/*"))
(require 'company-ycmd)
(company-ycmd-setup)

(require 'flycheck-ycmd)
(flycheck-ycmd-setup)
;;(flycheck-ycmd-setup)


(provide 'init-ycmd)
