;; usage:
;; $ offlineimap
;; $ mu index
;; M-x mu4e
;; from mu's official manual
;;----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/mu4e")
(require 'mu4e)
(setq mu4e-mu-binary "/usr/local/bin/mu")
;; default

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'sent)

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-update-interval 300)

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu
(setq smtpmail-default-smtp-server "smtpserver") ; needs to be specified before the (require)
(require 'smtpmail)


;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;; attempt to show images when viewing messages
(setq mu4e-view-show-images t
      mu4e-show-images t
      mu4e-view-image-max-width 800)


;; (setq mu4e-html2text-command "html2text -utf8 -width 72") ;; nil "Shel command that converts HTML
;; ref: http://emacs.stackexchange.com/questions/3051/how-can-i-use-eww-as-a-renderer-for-mu4e
(defun my-render-html-message ()
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
    (erase-buffer)
    (shr-insert-document dom)
    (goto-char (point-min))))
(setq mu4e-html2text-command 'my-render-html-message)

;; yt
(setq mu4e-view-prefer-html t) ;; try to render
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t) ;; read in browser
;; mu4e as default email agent in emacs
(setq mail-user-agent 'mu4e-user-agent)
(require 'org-mu4e)
                                        ;== M-x org-mu4e-compose-org-mode==
(setq org-mu4e-convert-to-html t) ;; org -> html
                                        ; = M-m C-c.=

;; give me ISO(ish) format date-time stamps in the header list
(setq  mu4e-headers-date-format "%Y-%m-%d %H:%M")

;; customize the reply-quote-string
;; M-x find-function RET message-citation-line-format for docs
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M %Z:\n")
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
      '( (:date          .  25)
         (:flags         .   6)
         (:from          .  22)
         (:subject       .  nil)))

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
;; attachments go here
(setq mu4e-attachment-dir  "~/Downloads")

;; should mu4e use fancy utf characters? NO. they're ugly.
;;(setq mu4e-use-fancy-chars 't)

(setq  ;; account info
 user-mail-address "j614023177@icloud.com"
 user-full-name  "royokong"
 message-send-mail-function 'smtpmail-send-it
 smtpmail-stream-type 'starttls
 smtpmail-default-smtp-server "smtp.mail.me.com"
 smtpmail-smtp-server "smtp.mail.me.com"
 smtpmail-smtp-service 587
 smtpmail-smtp-user "j614023177@icloud.com"
 mu4e-maildir "~/Maildir"
 mu4e-drafts-folder "/Drafts"
 mu4e-sent-folder   "/Sent Messages"
 mu4e-trash-folder  "/Deleted Messages"

 mu4e-maildir-shortcuts  '(("/iCloud/INBOX"    . ?i)
                           ("/Sent Items"   . ?s)
                           ("/Trash"        . ?t)
                           ("/All Mail"     . ?a))


 mu4e-compose-signature (concat
                         "royokong\n"
                         "Email: j614023177@iclloud.com\n"
                         "\n"))





(provide 'init-mail)
