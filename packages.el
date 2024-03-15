;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! mixed-pitch)
(when (package! lsp-bridge
        :recipe (:host github
                 :repo "manateelazycat/lsp-bridge"
                 :branch "master"
                 :files ("*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
                 ;; do not perform byte compilation or native compilation for lsp-bridge
                 :build (:not compile)))
  (package! markdown-mode)
  (package! yasnippet))
(package! minions)
(package! org-modern :pin "98532cd61795f3f41fffe7d4f0fa4021d8c73ffa")
(package! catppuccin-theme)
(package! golden-ratio)
(package! org-appear :recipe (:host github :repo "awth13/org-appear")
  :pin "81eba5d7a5b74cdb1bad091d85667e836f16b997")
