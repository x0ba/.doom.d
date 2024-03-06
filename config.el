;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Daniel Xu"
      user-mail-address "hey@x0ba.lol")

;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down (that isn't worth an entry in my notes). I can
;; do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

;;
;;;; UI

(setq doom-theme 'doom-rose-pine)
(remove-hook 'window-setup-hook #'doom-init-theme-h)
(add-hook 'after-init-hook #'doom-init-theme-h 'append)
(setq doom-font (font-spec :family "Maple Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16 :weight 'medium))

;; Line numbers are pretty slow all around. The performance boost of disabling
;; them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; org mode
(setq org-directory "~/org/")
(after! org-agenda
  (setq org-agenda-files (list "~/org/school.org"
                               "~/org/todo.org")))

;; use my mixed pitch font for org mode
(use-package mixed-pitch
  :hook
  ;; If you want it in all text modes:
  (text-mode . mixed-pitch-mode))

;; better defaults
(setq scroll-margin 2
      auto-save-default t
      display-line-numbers-type nil
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…")

(setq initial-frame-alist default-frame-alist)

;; zen-mode is a bit too overzealous when zooming in
(setq +zen-text-scale 0.8)

;;
;;; Modules

;;; :completion company
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(after! company
  (setq company-idle-delay nil))

;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Implicit /g flag on evil ex substitution, because I use the default behavior
;; less often.
(setq evil-ex-substitute-global t)

;;
;;; Keybinds

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;;; :ui doom-dashboard
(setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
;; Hide the menu for as minimalistic a startup screen as possible.
(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

;;; :app everywhere
(after! emacs-everywhere
  ;; Easier to match with a bspwm rule:
  ;;   bspc rule -a 'Emacs:emacs-everywhere' state=floating sticky=on
  (setq emacs-everywhere-frame-name-format "emacs-anywhere")

  ;; The modeline is not useful to me in the popup window. It looks much nicer
  ;; to hide it.
  (remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

  ;; Semi-center it over the target window, rather than at the cursor position
  ;; (which could be anywhere).
  (defadvice! center-emacs-everywhere-in-origin-window (frame window-info)
    :override #'emacs-everywhere-set-frame-position
    (cl-destructuring-bind (x y width height)
        (emacs-everywhere-window-geometry window-info)
      (set-frame-position frame
                          (+ x (/ width 2) (- (/ width 2)))
                          (+ y (/ height 2))))))

;;;; langs
;; Nix
(set-formatter! 'alejandra "alejandra --quiet" :modes '(nix-mode))

;;;; MacOS
;; Use mac-pseudo-daemon to
;; keep an instance of emacs
;; running in the background, as I use
;; emacs-macport which doesnt support
;; emacs-daemon
(mac-pseudo-daemon-mode 1)
