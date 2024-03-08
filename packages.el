;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! mixed-pitch)
(package! mac-pseudo-daemon
  :recipe
  (:host github
   :repo "DarwinAwardWinner/mac-pseudo-daemon"))
(package! solaire-mode :disable t)
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
