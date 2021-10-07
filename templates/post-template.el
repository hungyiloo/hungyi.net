;;; post-template.el --- blog post template -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;  blog post template
;;
;;; Code:

(require 'charge)

(defun my/blog/render-post (post main)
  "Renders post template with POST particle and MAIN content."
  (charge-html
   (article
    :class "post"
    (h1 :class "post__title" ,(alist-get :title post))
    (section
     :class "post__meta"
     ,(when-let ((post-date (alist-get :date post)))
        `(span :class "datestamp" ,(format-time-string "%e %B, %Y" (date-to-time post-date)))))
    (section
     :class "post__description"
     ,(when-let ((post-description (alist-get :description post)))
        `(p ,post-description)))
    (section ,main))))

(defun my/blog/render-post-meta (post site)
  "Renders post meta tags with POST particle and SITE config."
  (charge-html
   ((meta :property "og:title" :content ,(alist-get :title post))
    (meta :property "og:url" :content ,(charge-url site post))
    (meta :property "og:description" :content ,(alist-get :description post))
    (meta :property "description" :content ,(alist-get :description post))
    (meta :property "og:image" :content ,(concat (alist-get :base-url site) "HY_Light_and_Color_2.svg"))
    (meta :property "og:type" :content "blog"))))

(provide 'post-template)
;;; post-template.el ends here
