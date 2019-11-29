;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Melanie's custom config

;; Remap Esc to jk
(setq-default evil-escape-key-sequence "jk")

;; Split windows right and down
(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)

;; Follow symlinks to (git) repos
(setq vc-follow-symlinks t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for the solarized theme and powerline
(setq theming-modifications
      '((solarized
         (mode-line :foreground "#e9e2cb" :background "#2075c7"
                    :inverse-video nil)
         (powerline-active1 :foreground "#e9e2cb" :background "#2075c7"
                            :inverse-video nil)
         (powerline-active2 :foreground "#e9e2cb" :background "#2075c7"
                            :inverse-video nil)
         (mode-line-inactive :foreground "#2075c7" :background "#e9e2cb"
                             :inverse-video nil)
         (powerline-inactive1 :foreground "#2075c7" :background "#e9e2cb"
                              :inverse-video nil)
         (helm-selection :foreground "#b58900" :weight bold
                         :inverse-video nil)
         (helm-source-header :background "#b58900" :weight bold
                             :inverse-video nil)
         (helm-buffer-directory :background "unspecified")
         (helm-buffer-file :background "unspecified")
         (cursor :background "#b58900")
         (org-todo :background "unspecified" :foreground "#b58900"
                   :weight bold :inverse-video nil)
         (org-done :background "unspecified" :foreground "#465a61"
                   :weight bold :inverse-video nil)
         (font-lock-comment-face :background "unspecified" :slant italic)
         (term :background "unspecified")
         )))
(set-terminal-parameter nil 'background-mode 'dark)
(set-frame-parameter nil 'background-mode 'dark)
(spacemacs/load-theme 'solarized)

;; Avoid the search wrapping around
(setq isearch-wrap-function '(lambda nil))

;; Expand tabs, set width to 4 by default, 2 for shell scripts
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq sh-basic-offset 2)


;;;;;;;;;;;;;;;;;;;
;; Shell / terminal
;;
;; Fix line mode
(setq term-char-mode-point-at-process-mark nil)
;; When we open a shell we open it in a vertical split of 80 char width
(defun db/shell-create()
  (spacemacs/default-pop-shell)
  (enlarge-window-horizontally (- 80 (window-width))))
(spacemacs/set-leader-keys "'" (lambda () (interactive) (db/shell-create)))
;; Allow renaming (using same shortcut as in tmux)
(spacemacs/set-leader-keys "b$" 'rename-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modifications for org mode
;;
;; Nicer (?) bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))

;; More keywords
(setq org-todo-keywords '((sequence "TODO" "IN PROGRESS" "WAITING" "|" "DONE")))

;; Export more suitable for discussions
(setq org-latex-packages-alist '(("margin=1cm" "geometry" nil)))
(add-to-list 'org-latex-packages-alist '("T1" "fontenc" t))
(setq org-export-with-toc nil)
(setq org-export-with-tags t)
(setq org-export-with-author nil)
(setq org-export-date nil)
(setq org-export-with-section-numbers nil)
(setq org-latex-default-class "discussion")

(add-to-list 'org-latex-classes '(
 "discussion"
 "\\documentclass[11pt,a4paper]{article}
  \\usepackage{sectsty}
  \\sectionfont{
    \\normalfont
    \\fontfamily{phv}
    \\fontsize{12}{15}
    \\bfseries}
  \\subsectionfont{
    \\normalfont
    \\fontfamily{phv}
    \\fontsize{10}{13}
    \\bfseries}
  \\subsubsectionfont{
    \\normalfont
    \\fontfamily{phv}
    \\fontsize{10}{13}
    \\bfseries}"
 ("\\section{%s}"       . "\\section*{%s}")
 ("\\subsection{%s}"    . "\\subsection*{%s}")
 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
 ("\\paragraph{%s}"     . "\\paragraph*{%s}")
 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adjustments for smartparens
;; Unfortunately this does the opposite of what I'd expect:
;;(sp-pair "(" nil :unless '(sp-point-before-eol-p))
;;(sp-pair "\\\" nil :unless '(sp-point-before-eol-p))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++ specific settings
(defun custom-co-mode-common-hook()
  (auto-fill-mode)
  (setq fill-column 80)
  (setq c-basic-offset 'tab-width))  ;; 4 as per above
(add-hook 'c-mode-common-hook 'custom-c-mode-common-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General prog-mode settings
(setq whitespace-style '(trailing face lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
(add-hook 'prog-mode-hook 'whitespace-mode)
