; init.el 
;
; Emacs custom initializaiton file
; modified [2013.07.23] by <williamdemeo@gmail.com>
; modified [2011.11.29] by <williamdemeo@gmail.com>
; modified [2009.04.26] by <williamdemeo@gmail.com>
; modified [2004.01.09] by <williamdemeo@yahoo.com>


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(message "Loading init.el")

(load "~/.emacs.d/custom_wjd_init.el")

;(load "~/.emacs.d/Stanford_init.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(case-replace nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "bc4b650c41b16b98166b35da94b366c6a9e1e7883bbf4937c897fb7bd05aa619" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(fill-column 80)
 '(font-lock-maximum-decoration t)
 '(fringe-mode 1 nil (fringe))
 '(gutter-buffers-tab-visible-p nil)
 '(org-journal-dir "~/git/org/journal/")
 '(package-selected-packages
   (quote
    (zenburn-theme zenburn unicode-input org-journal markdown-preview-eww markdown-mode mandoku-tls lean-mode labburn-theme intero hc-zenburn-theme ghub color-theme-zenburn color-theme-solarized color-theme-monokai color-theme-github)))
 '(paren-mode (quote paren) nil (paren))
 '(scrollbars-visible-p nil)
 '(tool-bar-mode nil)
 '(toolbar-visible-p nil)
 '(unshifted-motion-keys-deselect-region nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
