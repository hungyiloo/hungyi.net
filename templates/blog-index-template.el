;;; blog-index-template.el --- blog index template -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;  blog index template
;;
;;; Code:

(require 'charge)

(defun my/blog/template-blog-index (posts site)
  "Renders blog index with all POSTS and SITE config."
  ;; Sort posts in reverse date order.
  ;; ISO8601 date strings are sortable lexicographically
  (setq posts
        (sort (copy-sequence posts)
              (lambda (a b)
                (string-greaterp
                 (plist-get a :date)
                 (plist-get b :date)))))
  `((div :class "section-header" "Latest")
    (ul
     :class "featured posts"
     ,@(mapcar
        (lambda (post) (my/blog/render-blog-index-item post site))
        (seq-take posts 1)))
    (div :class "section-header" "Older")
    (ul
     :class "posts"
     ,@(mapcar
        (lambda (post) (my/blog/render-blog-index-item post site))
        (seq-drop posts 1)))))

(defun my/blog/render-blog-index-item (post site)
  "Renders individual POST particle in blog index given the SITE config."
  `(li
    :class "post-item"
    (a
     :href ,(charge-url site post)
     (span :class "post-title" ,(plist-get post :title))
     ,(when-let ((post-date (plist-get post :date)))
        `(span
          :class "post-date datestamp"
          ,(format-time-string "%e %B, %Y" (date-to-time post-date))))
     ,(when-let ((post-description (plist-get post :description)))
        `(div :class "post-description" ,post-description)))))

(provide 'blog-index-template)
;;; blog-index-template.el ends here
