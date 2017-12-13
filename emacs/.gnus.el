(setq user-mail-address	"male.schmitt@posteo.de"
      user-full-name	"Matthias Schmitt")

(setq gnus-select-method '(nntp "foo.bar.com"))
(add-to-list 'gnus-secondary-select-methods '(nntp "localhost"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))
(add-to-list 'gnus-secondary-select-methods '(nnml ""))

(setq mail-sources '((pop :server "posteo.de"
                          :user "male.schmitt"
                          :password "secret")))

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "posteo.de"
      smtpmail-smtp-service 587
      smtpmail-stream-type "starttls")
