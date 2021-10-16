;;; post-template.el --- blog post template -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;  blog post template
;;
;;; Code:

(require 'charge)

(defun my/blog/template-post (post main)
  "Renders post template with POST particle and MAIN content."
  `(article
    :class "post"
    (h1 :class "post__title" ,(plist-get post :title))
    (section
     :class "post__meta"
     ,(when-let ((post-date (plist-get post :date)))
        `(span :class "datestamp" ,(format-time-string "%e %B, %Y" (date-to-time post-date)))))
    (section
     :class "post__description"
     ,(when-let ((post-description (plist-get post :description)))
        `(p ,post-description)))
    (section ,main)))

(defun my/blog/template-post-meta (post site)
  "Renders post meta tags with POST particle and SITE config."
  `((meta :property "og:title" :content ,(plist-get post :title))
    (meta :property "og:url" :content ,(charge-url site post))
    (meta :property "og:description" :content ,(plist-get post :description))
    (meta :property "description" :content ,(plist-get post :description))
    (meta :property "og:image" :content ,(concat (plist-get site :base-url) "HY_Light_and_Color_2.svg"))
    (meta :property "og:type" :content "blog")))

(provide 'post-template)
;;; post-template.el ends here
