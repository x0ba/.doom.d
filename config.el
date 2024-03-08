(setq user-full-name "Daniel Xu"
      user-mail-address "hey@x0ba.lol")

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

(setq doom-theme 'doom-rose-pine)

(setq doom-font (font-spec :family "Maple Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 16 :weight 'medium))

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

(after! doom-modeline
  (setq evil-normal-state-tag "<λ>"
        evil-insert-state-tag "<I>"
        evil-visual-state-tag "<V>"
        evil-motion-state-tag "<M>"
        evil-emacs-state-tag "<EMACS>")

  (setq doom-modeline-modal-icon nil
        doom-modeline-major-mode-icon t
        doom-modeline-minor-modes t
        doom-modeline-major-mode-color-icon t
        doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
        doom-modeline-buffer-encoding nil
        inhibit-compacting-font-caches t
        find-file-visit-truename t)

  (custom-set-faces!
    '(doom-modeline-evil-insert-state :inherit doom-modeline-urgent)
    '(doom-modeline-evil-visual-state :inherit doom-modeline-warning)
    '(doom-modeline-evil-normal-state :inherit doom-modeline-buffer-path))

  (setq doom-modeline-enable-word-count t))          ;; Show word count

(use-package! minions
  :hook (after-init . minions-mode))
(setq doom-modeline-height 35)
(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(setq default-frame-alist '((min-height . 1)  '(height . 45)
                            (min-width  . 1)  '(width  . 81)
                            (vertical-scroll-bars . nil)
                            (internal-border-width . 15)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)))

(setq initial-frame-alist default-frame-alist)
(setq-default line-spacing 0.24)

(custom-set-faces!
  `(vertical-border :background ,(doom-color 'bg) :foreground ,(doom-color 'bg)))
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(setq scroll-margin 2
      auto-save-default t
      display-line-numbers-type 'relative
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…")
(global-subword-mode 1)

(setq +zen-text-scale 0.8)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq evil-ex-substitute-global t)

(setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

(use-package! lsp-bridge
  :config
  (setq lsp-bridge-enable-log nil
        lsp-bridge-nix-lsp-server 'nil)
  (global-lsp-bridge-mode))

(mac-pseudo-daemon-mode 1)

(setq org-directory "~/org/")
(after! org-agenda
  (setq org-agenda-files (list "~/org/school.org"
                               "~/org/todo.org")))

(custom-theme-set-faces!
  'doom-rose-pine
  '(org-level-4 :inherit outline-3 :height 1.1)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-2 :inherit outline-2 :height 1.5)
  '(org-level-1 :inherit outline-1 :height 1.7)
  '(org-document-title  :height 1.7 :underline nil))
