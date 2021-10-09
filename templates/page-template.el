;;; page-template.el --- blog page template -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;  blog page template
;;
;;; Code:

(require 'charge)

(defun my/blog/template-page (page main)
  "Renders page template with PAGE particle and MAIN content."
  `(article
    :class "page"
    (h1 :class "page__title" ,(alist-get :title page))
    (section ,main)))

(provide 'page-template)
;;; page-template.el ends here
