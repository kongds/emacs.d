;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;;load finish track
(run-at-time
 "10 sec"
 nil
 (lambda ()
   (progn
     (setq b (get-buffer-create "load-music-track"))
     (setq display-buffer-alist '(( "load-music-track" .
                                    (display-buffer-no-window
                                     . '(allow-no-window  . t)))))
     (async-shell-command "mplayer ~/.emacs.d/musics/load.aifc&" b nil)
     (set-process-sentinel (get-process "Shell")
                           '(lambda (process event)
                              (kill-buffer "load-music-track")
                              (setq display-buffer-alist nil))))))

(let ((minver "23.3"))
  (when (version<= emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)


(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)

(require 'init-recentf)
(require 'init-smex)
;; If you really prefer ido to ivy, change the comments below. I will
;; likely remove the ido config in due course, though.
;; (require 'init-ido)
(require 'init-ivy)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)
(require 'init-fci)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

;;(require 'init-projectile)

(require 'init-compile)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(unless (version<= emacs-version "24.3")
  (require 'init-haskell))
(require 'init-elm)
(require 'init-ruby-mode)
(require 'init-rails)
(require 'init-sql)

(require 'init-paredit)
(require 'init-lisp)
(require 'init-slime)
(unless (version<= emacs-version "24.2")
  (require 'init-clojure)
  (require 'init-clojure-cider))
(require 'init-common-lisp)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-folding)
(require 'init-dash)
(require 'init-ledger)
(require 'init-ace)
(require 'init-spaceline)
(require 'init-helm)
(require 'init-helm-gtags)
(require 'init-xcode)

;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)


(provide 'init)

(message "插入插入栓")
;;(shell-command "插入插入栓say ")
(message "开放脊椎传导系统")
;;(shell-command "say 开放脊椎传导系统")
(message "准备连接")
;;(shell-command "say 准备连接")
(message "插头固定完毕")
;;(shell-command "say 插头固定完毕 ")
(message "开始第一次接触")
;;(shell-command "say 开始第一次接触")
(message "插入栓注水")
;;(shell-command "say 插入栓注水 ")
(message "插头内注水中，距离满充还有20")
;;(shell-command "say 插头内注水中，距离满充还有20")
(message "LCL浓度没有异常，压力正常")
;;(shell-command "say LCL浓度没有异常，压力正常")
(message "主电源接通")
;;(shell-command "say 主电源接通")
(message "动力传送至所有回路，没有问题")
;;(shell-command "say 动力传送至所有回路，没有问题")
(message "进行第二次接触")
;;(shell-command "say 进行第二次接触")
(message "A10神经连接无异常")
;;(shell-command "say A10神经连接无异常")
(message "LCL电量正常")
;;(shell-command "say LCL电量正常")
(message "思考形式以汉语为基础原则")
;;(shell-command "say 思考形式以汉语为基础原则")
(message "初期接触没有任何问题")
;;(shell-command "say 初期接触没有任何问题")
(message "内部电压维持现状，充电中")
;;(shell-command "say 内部电压维持现状，充电中")
(message "谐波均为正常值")
;;(shell-command "say 谐波均为正常值")
(message "没有失控现象")
;;(shell-command "say 没有失控现象")
(message "各部联动系统，确认运作")
;;(shell-command "say 各部联动系统，确认运作")
(message "准备发射")
;;(shell-command "say 准备发射")
(message "第1锁定栓释放")
;;(shell-command "say 第1锁定栓释放")
(message "确认解除")
;;(shell-command "say 确认解除")
(message "脐带式管线桥天艰移动")
;;(shell-command "say 脐带式管线桥天艰移动")
(message "第2锁定栓释放")
;;(shell-command "say 第2锁定栓释放")
(message "第1枸束器移除")
;;(shell-command "say 第1枸束器移除")
(message "第2枸束器移除")
;;(shell-command "say 第2枸束器移除")
(message "解除从1号到15号的安全装置")
;;(shell-command "say 解除从1号到15号的安全装置")
(message "确认解除")
;;(shell-command "say 确认解除")
(message "现在初号机的状态是”FREE“")
(message "内部电源充电完毕")
(message "外部电源插座一切正常")
;;(shell-command "say 外部电源插座一切正常")
(message "发射准备完成")
;;(shell-command "say 发射准备完成")
(message "发射！！！！！！！！！！！")
;;(dark)





(put 'set-goal-column 'disabled nil)


;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
