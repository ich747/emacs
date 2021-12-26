;; -*- Mode: Emacs-Lisp ; Coding : utf-8 -*-


;;<先史>-----------------------------------------------*

;; <ディレクトリ構成>

;; <\ディレクトリ構成>

;; <leaf install code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf el-get :ensure t);:use github
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; <\leaf install code>

;;<\先史>----------------------------------------------*



;;<Pkg via leaf>---------------------------------------*

(leaf *use-pkg_2_leaf
  :doc "You can try to transform On *scratch*"
  :config
  (leaf use-package
    :ensure t
    :require t)
  (leaf leaf-convert
    :ensure t))


(leaf *paren
  :doc "highlight matching paren"
  :tag "builtin"
  :custom ((show-paren-delay . 0.1))
  :global-minor-mode show-paren-mode)


(leaf *key-binds
  :doc "define my key-binds"
  :tag "builtin" "internal"
  :config
  (defalias 'yes-or-no-p 'y-or-n-p))

;;</Pkg via leaf>---------------------------------------*




;;exportするための宣言
(provide 'init)


;----
; 3rd_PARTY
;----

;;clock
;(require 'sky-color-clock)
;(sky-color-clock-initialize 33) ; FUK, Japan
;(setq sky-color-clock-format "%H:%M")
;(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
