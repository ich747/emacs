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
    (leaf-keywords-init)
    ))
;; <\leaf install code>
;;<\先史>----------------------------------------------*


;;<Pkg via leaf>---------------------------------------*

(leaf *USER
  :custom
  (user-full-name . "Hay Ich")
  (user-mail-address . "ich.hub.747@gmail.com")
  (user-login-name . "ich"))




(leaf *LEAF-CONVERT
  :doc "You can try to transform On *scratch*"
  :config
  (leaf use-package
    :tag "package"
    :ensure t
    :require t)
  (leaf leaf-convert
    :ensure t))





(leaf FRAME
  :doc "フレームに関する設定"
  :config
  (leaf start-up
    :doc "スタートアップの表示をしない"
    :custom
    (inhibit-startup-message . t)
    (inhibit-startup-screen  . t))
  (leaf title-bar
    :doc "タイトルバーにフルパス表示"
    :custom
    (frame-title-format . "%f"))
  (leaf tool-bar
    :doc "ツールバー要らない"
    :custom
    (tool-bar-mode . nil))
  (leaf column-number
    :doc "行に関する変更"
    :config
    (leaf col-num
      :doc "行数をミニバッファ/左マージンに表示"
      :custom
      (column-number-mode . t)
      (global-linum-mode  . t)))
  (leaf days
    :doc "月日をミニバッファに表示"
    :custom
    (display-time-string-forms . '((format "%s/%s(%s)" month day dayname)))
    (display-time-mode         . t))
  (leaf y-or-n
    :doc "y or n"
    :config (defalias 'yes-or-no-p 'y-or-n-p)))




(leaf WRITINGS
  :doc "書く設定"
  :config
  (leaf charactor
    :tag "builtin"
    :preface
    (leaf encode-decode
      :tag "encode" "decode" "Japanese"
      :custom ((set-language-environment . "Japanese")
	       (set-language-environment . 'utf-8)
	       (prefer-coding-system . 'utf-8)))
    :config
    (leaf font
      :doc "font指定"
      :config
      (leaf english
	:config
	(set-face-attribute 'default nil :family "Menlo" :height 128))
      (leaf japanese
	:config))
    (leaf char-scale
      :doc "文字幅"
      :custom
      (face-font-rescale-alist . '((".*Menlo.*" . 1.0) ("-cdac$" . 1.3))))
    (leaf paren
      :tag "builtin"
      :doc "括弧の補完など"
      :custom
      (show-paren-delay   . 0.0)
      (show-paren-style   . 'expression)
      (show-paren-mode    . t)
      (electric-pair-mode . t)
      )))

(leaf FILE_SYSTEM
  :doc "ファイルの読み書き保存に関する設定"
  :config
  (leaf *saving-system
    :config
    (leaf lock-file
      :tag "builtin"
      :doc "ロックファイル作成をしない"
      :config (setq create-lockfiles nil))
    (leaf backup-file
      :tag "builtin"
      :doc "バックアップファイルの作成を/backupに変更"
      :custom
      `((auto-save-timeout              . 15)
	(auto-save-interval             . 60)
	(auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
	(backup-directory-alist         . '((".*" . ,(locate-user-emacs-file "backup"))
					    (,tramp-file-name-regexp . nil)))
	(version-control                . t)
	(kept-new-versions              . 3)
	(kept-old-versions              . 1)
	(delete-old-versions            . t)
	(auto-save-list-file-prefix     . ,(locate-user-emacs-file "backup/.saves-")))))

  (leaf revert-buffer
    :disabled t;期待通り機能せず
    :tag "builtin" "myconfig"
    :doc "現在のバッファの再読み込み"
    :preface
    (defun my:revert-buffer (&optional force-reverting)
      "revert-buffer-no-confirm-version"
      (interactive "P")
      (if (or force-reverting (not (buffer-modified-p)))
	  (revert-buffer :ignore-auto :noconfirm)
	(error "The buffer has been modified")))
    :bind ("M-r" . my:revert-buffer)))


(leaf KEYBIND
  :tag "builtin"
  :doc "便利キーバインド"
  :bind
  ("C-m"    . 'newline-and-indent)
  ("C-t"    . 'other-window)
  ("C-x k"  . 'kill-this-buffer)
  ("M-<up>" . 'switch-to-buffer)
  ("C-z"    . 'hs-minor-mode)

  :custom
  (kill-whole-line . t)
  :config
  (leaf my:func-keybind
    :preface
    (defun my:enumerate-region (start end)
      "先頭が-から始まる行を箇条書きにする"
      (interactive "r")
      (save-excursion
	(let ((no 1));;no is Number of col
	  (goto-char start);;リージョンの先頭に移動
	  (while (re-search-forward "^-\\|^[0-9]+)" end t);;-から始まる行の検索
	    (replace-match (format "%d) " no))
	    (setq no (+ no 1)))))))
    :bind
    ("C-="    . my:enumerate-region))


(leaf flycheck
  :doc "リアルタイムエラー表記。On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "拾い物" "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)


(leaf ZONE
  :tag "builtin"
  :doc "zone拡張"
  :
  :preface
  (defvar zone-programs [ zone-pgm-rotate-LR-variable ])
  (defun my:matrix ()
    "デフォルトを緑にしzoneする。終了後は戻してmessage"
    (interactive)
    (let ((default-color (face-foreground 'default)))
      (set-foreground-color "green")
      (zone)
      (set-foreground-color default-color)
      (message "They're watching you...")))
  :bind ("C-#" . my:matrix)
  :custom (zone-when-idle . 10))






(leaf *delete-file-if-no-contents
  :tag "拾い物"
  :url "https://uwabami.github.io/cc-env/Emacs.html"
  :doc "delete file if no contents"
  :preface
  (defun my:delf-no-contents ()
    (when (and (buffer-file-name (current-buffer))
	       (= (point-min) (point-max)))
	(delete-file (buffer-file-name (current-buffer)))))
  :hook (after-save-hook . my:delf-no-contents))






(leaf *trailing-white-space
  :tag "拾い物"
  :url "https://uwabami.github.io/cc-env/Emacs.html"
  :doc "行末の空白/改行の削除　ただし.mdなどを除く"
  :preface
  (defvar my:delete-trailing-whitespace-exclude-suffix
    (list "\\.md$"))
  (defun my:delete-trailing-whitespace ()
    (interactive)
    (eval-when-compile (require 'cl-lib))
    (cond ((equal nil
		  (cl-loop for pattern in my:delete-trailing-whitespace-exclude-suffix
			   thereis (string-match pattern buffer-file-name)))
	   (delete-trailing-whitespace))))
  :hook (before-save-hook . my:delete-trailing-whitespace))











(leaf THIRD_PARTY
  :tag "3rd_party"
  :config
  (leaf sky-color-clock
    :tag "3rd_party" "web_api"
    :url "https://github.com/zk-phi/sky-color-clock"
    :req "sky api"
    :doc "空の色を表示"
    :el-get "zk-phi/sky-color-clock"
    :preface
    (defun my:sky-color-clock-form ()
      "左よせにする"
      (let* ((sky-color-clock-str
              (propertize (sky-color-clock) 'help-echo (format-time-string "Sky color clock\n%F (%a)")))
             (mode-line-right-margin
              (propertize " " 'display `(space :align-to (- right-fringe ,(length sky-color-clock-str))))))
	(concat mode-line-right-margin sky-color-clock-str)))
    :custom
    (sky-color-clock-initialize . 33)
    (sky-color-clock-format     . "%H:%M")
    :custom
    (mode-line-end-spaces . '(:eval (my:sky-color-clock-form)))
    ;:config (push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
    ))








;;</Pkg via leaf>---------------------------------------*

;;exportするための宣言
(provide 'init)
