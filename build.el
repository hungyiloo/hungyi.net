;;; build.el --- builds my static blog using charge.el -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;; builds my static blog using charge.el
;;;
;;; Code:
(load-file "~/.config/emacs/early-init.el")
(load-file "~/.config/emacs/init.el")

(require 'charge)

;; Load templates
(dolist (template (file-expand-wildcards "templates/*.el")) (load-file template))
(declare-function my/blog/render-base ())
(declare-function my/blog/render-blog-index ())
(declare-function my/blog/render-post ())
(declare-function my/blog/render-post-meta ())
(declare-function my/blog/render-page ())

;; Collect particles and render site
(let* ((posts (charge-collect-org (file-expand-wildcards "content/posts/*.org")))
       (pages (charge-collect-org (file-expand-wildcards "content/*.org")))
       (static-files (charge-collect-files (file-expand-wildcards "static/*")))
       (blog-index (list (charge-particle :posts posts))))

  (charge-site
   :name "Hung-Yi’s Journal"
   :base-url (cond ((getenv "PRODUCTION") "https://hungyi.net/")
                   (t "http://localhost:5000/"))
   :output "output"

   (charge-route blog-index
     :url ""
     :path '("index.html" "posts/index.html")
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/render-blog-index (alist-get :posts particle) site))
              destination)))

   (charge-route posts
     :url (charge-format "posts/%s" :slug)
     :path (charge-format "posts/%s/index.html" :slug)
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/render-post particle (charge-export-particle-org particle))
               (alist-get :title particle)
               (my/blog/render-post-meta particle site))
              destination)))

   (charge-route pages
     :url (charge-format "%s" :slug)
     :path (charge-format "%s/index.html" :slug)
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/render-page particle (charge-export-particle-org particle))
               (alist-get :title particle))
              destination)))

   (charge-route static-files
     :url (charge-format "%s" :filename)
     :path (charge-format "%s" :filename)
     :emit (lambda (destination particle _route _site)
             (copy-file (alist-get :path particle) destination t)))))

(provide 'build)
;;; build.el ends here
