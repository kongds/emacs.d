;;emmms
(require 'emms-player-mplayer)
(require 'emms-setup)
(require 'emms)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-player-simple)
(require 'emms-playlist-mode)
(require 'emms-info)
(require 'emms-cache)
(require 'emms-mode-line)
(require 'emms-playing-time)
(require 'emms-score)
(require 'emms-volume)

(setq exec-path (append exec-path '("/usr/local/bin")))
(add-to-list 'load-path "~/.emacs.d/site-lisp/emms/lisp")


(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
  (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
  "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
(setq emms-playlist-buffer-name "*Music*")
(setq emms-source-file-default-directory "/Users/royokong/Music/Emacs")
(add-hook 'emms-player-started-hook 'emms-show)
;;(add-hook 'emms-playlist-mode-hook '(emms-add-directory "/Users/royokong/Music/Emacs"))
(defun emms_next_show ()
  (interactive)
  (emms-random)
  (emms-show)
  )
(defun input_music ()
  (interactive)
  (emms-add-directory "/Users/royokong/Music/Emacs"))

(global-set-key (kbd "C-x x") 'emms_next_show)
(define-key emms-playlist-mode-map (kbd "C-x C-x") 'input_music)
(provide 'emms-local)
