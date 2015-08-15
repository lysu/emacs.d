
;; common
(require 'auto-complete)
(ac-config-default)
(local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)
(local-set-key "." 'semantic-complete-self-insert)
(local-set-key ">" 'semantic-complete-self-insert)

;; golang
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(require 'flymake-go)
(defun my-go-mode-hook ()
  (load-file "/Users/robi/.emacs.d/oracle/oracle.el")
  (setq gofmt-command "goimports")
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; speedbar
(require 'sr-speedbar)
(speedbar-add-supported-extension ".go")
(sr-speedbar-open)
(with-current-buffer sr-speedbar-buffer-name
      (setq window-size-fixed 'width))


(provide 'init-go)
