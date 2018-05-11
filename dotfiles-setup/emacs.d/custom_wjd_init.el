; custom.el
;
; Emacs customization file
; modified [2013.07.23] by <williamdemeo@gmail.com>
; modified [2011.01.01] by <williamdemeo@gmail.com>

(message "Loading custom_wjd_init.el")

;(setq load-path (cons "~/.emacs.d" load-path))
(scroll-bar-mode -1)

;; Proof General IDE for Coq
(load-file "/usr/share/emacs/site-lisp/proofgeneral/generic/proof-site.el")
;;(load-file "~/opt/ProofGeneral/generic/proof-site.el")




;; If emacs is started in a new window, that window 
;; should be sized appropriately for your screen.
(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))

(when (display-graphic-p)
  (arrange-frame 187 48 70 0)  ; <<<< set the w h x y variables here
)

(require 'gnutls)
(add-to-list 'gnutls-trustfiles
             (expand-file-name
              "~/opt/tls/certificates/comodo.rsa.ca.intermediate.crt"))

;; package.el
(require 'package)

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives 
;;              '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

;; (setq package-archives '(
;; 			  ("gnu" . "http://elpa.gnu.org/packages/")
;;       ("marmalade" . "http://marmalade-repo.org/packages/")
;;       ("melpa" . "http://melpa.milkbox.net/packages/")
;;  ("melpa-stable" . "http://stable.melpa.org/packages/")
;;       ))

;; (add-to-list 'package-archives
;;   '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; (package-initialize)

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (package-initialize)


;;
;; For Magit
;;
;; If you want to use magit, install the magit package
;; (if you haven't done so already) with the following commands:
;; \M package-refresh-contents
;; \M package-install [Enter] magit
(define-key global-map "\M-gm" 'magit-status)


;;;;------ For Haskell ------------------------
;;
(require 'package)
(package-initialize)
(package-refresh-contents)

;; Install Intero
;; Intero comes with ghc-mod, flycheck, company
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

;; Tidal cycles
(add-to-list 'load-path "~/git/TEAMS/TypeFunc/gh/uh-mfc/haskelltalk/") ;; Look for tidal.el in ~/uh-mfc/haskelltalk/
(require 'tidal)
(setq tidal-interpreter "~/git/TEAMS/TypeFunc/gh/uh-mfc/haskelltalk/ghciscript")
;;;;------------------------------

;;;; ------ For Agda ----------------
 ;; (load-file (let ((coding-system-for-read 'utf-8))
 ;;                 (shell-command-to-string "agda-mode locate")))
;;;; --------------------------------


(setenv "LD_LIBRARY_PATH"
  (let ((current (getenv "LD_LIBRARY_PATH"))
        (new "/usr/local/lib"))
    (if current (concat new ":" current) new)))


;;;; ------ For LEAN ----------------
;; (setq lean-rootdir "/usr/local/lib/lean")
;; (setq load-path (cons "/usr/local/lib" load-path))
(setq lean-rootdir "~/git/PROGRAMMING/LEAN/gh/lean")
;(setq load-path (cons "~/git/PROGRAMMING/LEAN/gh/lean/src/emacs" load-path))
(require 'lean-mode)
;;;; --------------------------------



;;;;--------- For Scala -------------------
;; (unless (package-installed-p 'scala-mode2)
;;   (package-refresh-contents) (package-install 'scala-mode2))
;;;;----------------------------------------------

;;; uncomment this line to disable loading of "default.el" at startup
(setq inhibit-default-init t)


;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; The rest was mainly taken from my old init.el file
;; For other features left out of this version, see
;; the file old_custom_init.el


;;
;; Global key bindings
(define-key global-map "\C-cc" 'compile)
(define-key global-map "\C-cs" 'shell)
(define-key global-map "\C-cg" 'gdb)


;; (autoload 'noweb-mode "noweb-mode" "noweb mode." t)
;; (setq auto-mode-alist
;;       (cons '("\\.nw$" . noweb-mode) auto-mode-alist))

;; (add-hook 'noweb-mode-hook
;; 	  '(lambda ()
;; 	     (setq-default noweb-set-code-mode "matlab-mode")
;; 	     (setq-default noweb-set-doc-mode "LaTeX-mode")))

;; 
;;  LaTeX Mode
;;
(setq auto-mode-alist
      (cons '("\\.tex$" . LaTeX-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.def$" . LaTeX-mode) auto-mode-alist))
(add-hook 'LaTeX-mode-hook 
          (lambda () 
;	    (auto-fill-mode 1)
	    (font-lock-mode 1)))
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode



(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
       ("bib" . "kpsewhich -format=.bib %f")))


 (add-hook 'latex-mode-hook
 	  (lambda () 
; 	    (auto-fill-mode t)
	    (reftex-mode t)))


;; >>>> Set the default location for your main .bib database here <<<<
(setq reftex-default-bibliography '("~/Dropbox/RESEARCH/wjd.bib"))

;;
;;  BibTex Mode
;;
(setq auto-mode-alist
      (cons '("\\.bib$" . bibtex-mode) auto-mode-alist))
(add-hook 'bibtex-mode-hook 'turn-on-font-lock)

;;
;;  Markdown Mode
;;
(setq auto-mode-alist (append (list '("\\.md$" . markdown-mode)
                                    '("\\.markdown$" . markdown-mode))
                              auto-mode-alist))
(add-hook 'markdown-mode-hook (lambda ()
;				(auto-fill-mode 1)
				))

;;
;; NOTES
;;
;[Changing colours]
;  First, find the font name to change using the command:
;    M-x list-text-properties-at
;  Then, suppose you got `font-latex-math-face', edit ~/.Xdefaults and add:
;    Emacs.font-latex-math-face.attributeForeground: blue
;

;;
;; From file:///usr/share/doc/xemacs21/README.Debian
;;

;; make all fonts available from Options->Fonts menu
;(setq-default font-menu-ignore-scaled-fonts nil)

;; Word abbreviation mode (see LGE p. 74)
;	(setq-default abbrev-mode t)
;	(read-abbrev-file "~/.abbrev_defs")
;	(setq save-abbrevs t)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(agda2-include-dirs (quote ("." "/home/williamdemeo/git/PROGRAMMING/AGDA/agda-stdlib/src")))
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
; '(auto-fill-mode t)
 '(case-replace nil)
 '(column-number-mode t)
; '(custom-enabled-themes (quote (deeper-blue)))
; '(custom-enabled-themes (quote (color-theme-snowish)))
 '(fill-column 80)
 '(font-lock-maximum-decoration t)
 '(fringe-mode 1 nil (fringe))
 '(gutter-buffers-tab-visible-p nil)
 '(paren-mode (quote paren) nil (paren))
 '(scrollbars-visible-p nil)
 '(tool-bar-mode nil)
 '(toolbar-visible-p nil)
 '(unshifted-motion-keys-deselect-region nil))

  (set-face-attribute 'default (selected-frame) :height 110)
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(set-fringe-mode '(1 . 0))
(setq left-fringe-width 2)

; Set font
;(set-default-font "Inconsolata-12")

;; (require 'color-theme)
;;   (setq my-color-themes (list 'color-theme-billw 'color-theme-jsc-dark 
;;                               'color-theme-sitaramv-solaris 'color-theme-resolve
;;                               'color-theme-classic 'color-theme-jonadabian-slate
;;                               'color-theme-kingsajz 'color-theme-shaman
;;                               'color-theme-subtle-blue 'color-theme-snowish
;;                               'color-theme-sitaramv-nt 'color-theme-wheat
;; 			      'color-theme-adwaita 'color-theme-deeper-blue 
;; 			      'color-theme-dichromacy 'color-theme-ir-black 
;; 			      'color-theme-light-blue 'color-theme-manoj-dark
;; 			      'color-theme-misterioso 
;; 			      'color-theme-moe 'color-theme-moe-dark 'color-theme-moe-light 
;; 			      'color-theme-tango 'color-theme-tango-dark
;; 			      'color-theme-tsdh-dark 'color-theme-tsdh-light 
;; 			      'color-theme-wheatgrass 'color-theme-whiteboard 
;; 			      'color-theme-wombat 'color-theme-zenburn))
; Load theme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (color-theme-initialize)
;; (color-theme-zenburn)
;; (color-theme-tty-dark)
;; (load-theme 'monokai t)
;; (load-theme 'exu t)
;; (load-theme 'zenburn t)
;(color-theme-snowish)

;; Gap

      (autoload 'gap-mode "gap-mode" "Gap editing mode" t)
      (setq auto-mode-alist (apply 'list
                                   '("\\.g$" . gap-mode)
                                   '("\\.gap$" . gap-mode)
                                   auto-mode-alist))
;; org-mode
(require 'package)
;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(require 'org-journal)
(custom-set-variables
 '(org-journal-dir "~/git/org/journal/"))
;; (require 'ox-reveal)

(setq
 browse-url-browser-function 'browse-url-generic
 browse-url-generic-program "google-chrome")
