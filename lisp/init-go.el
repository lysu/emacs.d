
;; common
(require 'auto-complete)
(ac-config-default)
(local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)
(local-set-key "." 'semantic-complete-self-insert)
(local-set-key ">" 'semantic-complete-self-insert)


(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(menu-bar-mode 0)
(if (display-graphic-p)
      (progn
              (tool-bar-mode 0)))
(transient-mark-mode t)
(show-paren-mode t)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(define-key global-map "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-_" 'advertised-undo)
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)


(setq compilation-window-height 10)

(require 'golint)

;; golang
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")
(defun my-go-mode-hook ()
  (load-file "/Users/robi/.emacs.d/gorename/rename.el")
  (setq gofmt-command "goimports")
  (setq tab-width 4)
  (setq compile-command "go generate && go build -v && go test -v && go vet")
  (define-key go-mode-map "\C-cc" 'compile)
  (define-key go-mode-map "\C-c\C-c" 'comment-region)
  (define-key go-mode-map "\C-u\C-c\C-c" 'uncomment-region)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'flymake-go)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'go-mode-hook 'flycheck-mode)

(load-file "/Users/robi/.emacs.d/oracle/oracle.el")
;;(add-hook 'go-mode-hook (lambda () (go-oracle-mode t) ))

;; speedbar
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(speedbar-add-supported-extension ".go")
(defalias 'sb 'sr-speedbar-toggle)
;(sr-speedbar-open)
;(with-current-buffer sr-speedbar-buffer-name
;  (setq window-size-fixed 'width))

;(require 'go-direx) ;; Don't need to require, if you install by package.el
;(define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)

(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

(require 'neotree)
  (global-set-key [f8] 'neotree-toggle)

(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'yas-snippet-dirs "/Users/robi/.emacs.d/snippet/yasnippet-golang")

;(require 'popwin)
;(setq display-buffer-function 'popwin:display-buffer)

;(push '("^\*go-direx:" :regexp t :position left :width 0.4 :dedicated t :stick t)
;            popwin:special-display-config)


;;; helm-doc
(defvar my/helm-go-source
  '((name . "Helm Go")
    (candidates . go-packages)
    (action . (("Show document" . godoc)
	       ("Import package" . my/helm-go-import-add)))))

(defun my/helm-go-import-add (candidate)
  (dolist (package (helm-marked-candidates))
    (go-import-add current-prefix-arg package)))

(defun my/helm-go ()
  (interactive)
  (helm :sources '(my/helm-go-source) :buffer "*helm go*"))

(define-key go-mode-map (kbd "C-c C-d") 'my/helm-go)

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(set-face-attribute 'eldoc-highlight-function-argument nil
		    :underline t :foreground "green"
		    :weight 'bold)

(define-key go-mode-map (kbd "C-@") 'godef-jump-other-window)

(provide 'init-go)
