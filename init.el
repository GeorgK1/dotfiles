;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq inhibit-startup-message t) ;; Disable visible scrollbar

(scroll-bar-mode -1) ;; Disable the toolbar
(tool-bar-mode -1) ;; Disable tooltips
(set-fringe-mode 10)

(menu-bar-mode -1) ;; Disable the menu bar

(setq visible-bell t) ;; visual bell

(setq global-hl-line-modes nil) ;; disable line highlight
;; Line numbers
(column-number-mode)

;; set relative line numbers
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

;; Activate line numbering in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(set-face-attribute 'default nil :font "JetBrains Mono" :height 128)

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                          ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                          "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                          "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                          "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                          "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                          "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                          "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                          ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                          "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                          "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                          "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                          "\\\\" "://")))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :init (load-theme 'doom-zenburn t))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . 'counsel-M-x)
         ("C-M-j" . 'counsel-switch-buffer)
         ("C-x b" . 'counsel-ibuffer)
         ("C-x C-f" . 'counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
:commands (helpful-callable helpful-variable helpful-command helpful-key)
:custom
(counsel-describe-function-function #'helpful-callable)
(counsel-describe-variable-function #'helpful-variable)
:bind
([remap describe-function] . counsel-describe-function)
([remap describe-command] . helpful-command)
([remap describe-variable] . counsel-describe-variable)
([remap describe-key] . helpful-key))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(use-package general)

(use-package term
    :config
    (setq explicit-shell-file-name "bash")
    (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(defun gem/org-mode-setup ()
    (org-indent-mode)
    (visual-line-mode 1))

  (use-package org
    :hook (org-mode . gem/org-mode-setup)
    :config
    (setq org-ellipsis " ▾")
    (setq org-agenda-files
          '("~/Documents/org/Tasks.org"
            "~/Documents/org/Birthdays.org"))

    (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")))
    (setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer t))



(setq org-refile-targets
      '(("Archive.org" :maxlevel . 1)))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-tag-alist
      '(("@networks" . ?N)
        ("@programming" . ?P)
        ("@math" . ?M)
        ("@computers" . ?C)
        ("@internship" . ?I)
        ("@drill" . ?D)))


(setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))))

(setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Documents/org/Tasks.org" "Varia")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Documents/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ))

(use-package org-roam)

;; Automatically tangle our config.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/config.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp .t)
   (python . t)))
(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(add-to-list 'org-structure-template-alist '("idr" . "src idris"))

(use-package org-bullets
   :after org
   :hook (org-mode . org-bullets-mode))

  (defun gem/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

(use-package evil
  :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    :config
    (evil-mode 1)
    (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
    (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

    ;; Use visual line motions even outside of visual-line-mode buffers
    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

    ;; set leader key in all states
    (evil-set-leader nil (kbd "SPC"))

    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal)
    (evil-set-initial-state 'bs-mode 'emacs))
    (evil-set-initial-state 'idris-repl-mode 'insert)
    (evil-set-initial-state 'term-mode 'emacs)

(use-package evil-collection
 :after evil
 :config
 (evil-collection-init))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

  (use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
   :hook (lsp-mode . lsp-ui-mode))

(use-package python-mode
    :hook (python-mode . lsp-deferred)
    :config
    :custom
    (python-shell-interpreter "python3"))

(use-package typescript-mode

  :mode "\\.ts\\'"
   :hook (typescript-mode . lsp-deferred)
   :config
   (setq typescript-indent-level 2))

(use-package lsp-java
  :config (add-hook 'java-mode-hook 'lsp-deferred))

(global-set-key (kbd "C-c t") 'dap-java-run-test-method)

(use-package idris-mode
  :custom
  (idris-interpreter-path "~/.idris2/bin/idris2"))
  (add-to-list 'exec-path "~/.pack/bin")

(use-package clang-format)
(use-package irony)

(use-package php-mode)

(use-package yasnippet)
(yas-global-mode 1)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(global-company-mode 1)

(use-package lsp-treemacs
  :after lsp)

(use-package magit
    :commands (magit-status magit-get-current-branch)
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package flycheck)
(global-flycheck-mode 1)

(use-package pdf-tools)

(setq make-backup-files nil) ; stop creating ~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(global-auto-revert-mode 1) ;; enables auto revert
;; (add-hook 'after-save-hook 'lsp-format-buffer)

;; Fix tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(use-package simple-httpd)

(setq auto-save-timeout 3)
(setq auto-save-interval 20)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(keychain-enviroment yasnippet which-key use-package typescript-mode simple-httpd python-mode projectile php-mode pdf-tools org-roam org-bullets magit lsp-ui lsp-java ligature ivy-rich irony idris-mode helpful general flycheck evil-collection doom-themes doom-modeline counsel company-box clang-format all-the-icons))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
