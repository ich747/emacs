;; -*- Mode: Emacs-Lisp ; Coding : utf-8 -*-


;;<先史>-----------------------------------------------*
;; <ディレクトリ構成>
;; <\ディレクトリ構成>

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
    )
  (leaf bytecomp
    :custom
    ((byte-compile-warnings . '(not
                                obsolete
                                free-vars
                                unresolved
                                callargs
                                redefine
                                noruntime
                                cl-functions
                                interactive-only
                                make-local))
     (debug-on-error         . nil))
    :config
    (let ((win (get-buffer-window "*Compile-Log*")))
      (when win (delete-window win)))))



;;<\先史>----------------------------------------------*


;;<Pkg via leaf>---------------------------------------*

(leaf *USER
  :custom
  (user-full-name . "Hay Ich")
  (user-mail-address . "ich.hub.747@gmail.com")
  (user-login-name . "ich"))
(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :url "https://qiita.com/conao3/items/347d7e472afd0c58fbd7"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))
(leaf *LEAF-CONVERT
  :doc "You can try to transform On *scratch*"
  :config
  (leaf use-package
    :tag "package"
    :ensure t
    :require t)
  (leaf leaf-convert
    :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size   . 30)
	     (imenu-list-position . 'left))))

(leaf FRAME
  :doc "フレームに関する設定"
  :config
  
  (leaf debug-on-error
    :doc "デバッグ表示"
    :custom (debug-on-error . t))
  
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
    (tool-bar-mode . nil) :)

  (leaf tabbar
    :disabled t
    :tag "github"
    :ensure t)
  
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

(leaf FRAME_DESIGN
  :tag "3rd_party"
  :doc "GNU Emacs のデザインを変更する"
  :config

  (leaf modus-themes
    :tag "gitlab" "github"
    :url
    "https://gitlab.com/protesilaos/modus-themes.git"
    "https://protesilaos.com/emacs/modus-themes#h:3ed03a48-20d8-4ce7-b214-0eb7e4c79abe"
    :emacs> 26.1
    :ensure t
    :bind ("<f3>" . modus-themes-toggle)
    )
)


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
      (face-font-rescale-alist . '((".*Menlo.*" . 1.0) ("-cdac$" . 1.3)))))

  (leaf highlight
    :config

    (leaf hl-line
      :doc "ハイライト補完 現在の行"
      :custom-face
      ((hl-line quote ((t (:background "WhiteSmoke")))))
      :config (global-hl-line-mode t))
    
					;(leaf indent-guide
					;  :ensure t
					;  :custom
					;  (indent-guide-delay     . 0.0)
					;  (indent-guide-recursive . t))

    (leaf indent-tab
      :tag
      :doc "インデントを整えるコマンド"
      :config
      (leaf point-undo
	:tag "url" "myel"
	:url "http://www.emacswiki.org/cgi-bin/wiki/download/point-undo.el"
	:init
	(load "~/.emacs.d/myel/point-undo")
	:bind ([f7] . point-undo))
      
      (leaf all-indent
	:disabled t
	:req "point-undo"
	:after point-undo
	:preface
	(defun my:all-indent ()
	  (interactive)
	  (mark-whole-buffer)
	  (indent-region (region-beginning)(region-end))
	  (point-undo))
	:bind ("C-x C-j" . my:all-indent)))
    
    (leaf paren
      :tag "builtin"
      :doc "括弧の補完など"
      :custom
      (show-paren-delay   . 0.0)
      (show-paren-style   . 'expression)
      (show-paren-mode    . t)
      (electric-pair-mode . t)))
  )

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
	(auto-save-list-file-prefix     . ,(locate-user-emacs-file "backup/.saves-"))))
    
    (leaf time-stamp
      :hook (before-save-hook . time-stamp)
      :custom
      ((time-stamp-active     . t)
       (time-stamp-line-limit . 10)
       (time-stamp-start      . "$Lastupdate: 2")
       (time-stamp-end        . "\\$")
       (time-stamp-format     . "%Y-%02m-%02d %02H:%02M:%02S")))
    
    (leaf revert-buffer
      :tag "builtin" "myconfig"
      :doc "現在のバッファの再読み込み"
      :preface
      (defun my:revert-buffer (&optional force-reverting)
	"revert-buffer-no-confirm-version"
	(interactive "P")
	(if (or force-reverting (not (buffer-modified-p)))
	    (revert-buffer :ignore-auto :noconfirm)
	  (error "The buffer has been modified")))
      :bind ("M-r" . my:revert-buffer))
    
    (leaf autorevert
      :custom
      ((auto-revert-interval . 0.1))
      :hook
      (emacs-startup-hook . global-auto-revert-mode)))
  )

(leaf *MODE
  :doc "特定のファイル形式に対応する"
  :config

  (leaf Markdown
    :disabled t
    :config
    (leaf markdown-preview-mode
      :el-get "ancane/markdown-preview-mode"
      :require t
      :commands markdown-preview-mode
      :custom
      (markdown-preview-stylesheets . (list "github.css")))
    
    (leaf  markdown-mode
      :ensure t
      :require t
      :custom (("README\\.md\\'" . gfm-mode)
               ("\\.md\\'" . markdown-mode)
               ("\\.markdown\\'" . markdown-mode))
      :setq (markdown-command . "multimarkdown")))

  (leaf Python)
  (leaf Rust)
  (leaf Csv_and_Json)
  )

(leaf KEYBIND
  :tag "builtin"
  :doc "便利キーバインド"
  :bind
  ("C-m"    . 'newline-and-indent)
  ("C-t"    . 'other-window)
  ("C-x k"  . 'kill-this-buffer)
  ("M-<up>" . 'switch-to-buffer)
  ("M-t"    . 'leaf-tree-mode)
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
  :bind ("C-="    . my:enumerate-region))


(leaf flycheck
  :disabled t
  :doc "リアルタイムエラー表記。On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)



(leaf ZONE
  :tag "builtin"
  :doc "zone拡張"
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



(leaf THIRD_PARTY
  :tag "3rd_party" "github"
  :config
  
  (leaf sky-color-clock
    :el-get "zk-phi/sky-color-clock"
    :require t
    :custom
    (sky-color-clock-format . "%H:%M")
    :config
    (sky-color-clock-initialize 33);FUK
    (push '(:eval (sky-color-clock)) (default-value 'mode-line-format))))



;;</Pkg via leaf>---------------------------------------*

;;exportするための宣言
(provide 'init)
