;; -*- Mode: Emacs-Lisp ; Coding : utf-8 -*-

(require 'cl)


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





;; #分割した設定ファイルを読み込む

;(require 'init-loader)
;(init-loader-load "~/.emacs.d/conf")
;
;;; conf/  ----------------------
;;;ファイリング
;(load "filing")
;
;;;フレーム
;(load "frame")
;
;;;フォント & coding
;(load "font")
;
;;;キーバインド
;(load "keybind")
;
;;;言語ごとの設定
;(load "init-python")
;; -----------------------------


;----
; 3rd_PARTY
;----

;;clock
(require 'sky-color-clock)
(sky-color-clock-initialize 33) ; FUK, Japan
(setq sky-color-clock-format "%H:%M")
(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))