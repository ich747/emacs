;; -*- Mode: Emacs-Lisp ; Coding : utf-8 -*-

;;# PATH読み込み

;;サブディレクトリ含む再起的path読み込み
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "my_elisp" "thirdparty")

;; #Package管理

;;First contact
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)

  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))





;(require 'init-loader)
;(init-loader-load "~/.emacs.d/conf")
;(load "filing")
;(load "frame")
;(load "font")
;(load "keybind")

;----
; 3rd_PARTY
;----

;;clock
;(require 'sky-color-clock)
;(sky-color-clock-initialize 33) ; FUK, Japan
;(setq sky-color-clock-format "%H:%M")
;(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
