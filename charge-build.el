;;; charge-build.el --- builds my static blog using charge.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(let* ((posts (charge-collect-org (file-expand-wildcards "content/posts/*.org")))
       (pages (charge-collect-org (file-expand-wildcards "content/*.org")))
       (static-files (charge-collect-files (file-expand-wildcards "theme/static/*")))
       (blog-index (list (charge-particle :posts posts))))

  (charge-site
   :base-url "http://localhost:5000/"
   :output "output"

   (charge-route blog-index
     :url ""
     :path '("index.html" "posts/index.html")
     :emit (lambda (destination particle _route site)
             (charge-write
              (charge-html
               `(body
                 (ul
                  ,(mapcar
                    (lambda (post) `(li (a :href ,(charge-url site post) ,(alist-get :title post))))
                    (alist-get :posts particle)))))
              destination)))

   (charge-route posts
     :url (charge-format "posts/%s" :slug)
     :path (charge-format "posts/%s/index.html" :slug)
     :emit (lambda (destination particle _route _site)
             (charge-write
              (charge-html `(body ,(charge-export-particle-org particle)))
              destination)))

   (charge-route pages
     :url (charge-format "%s" :slug)
     :path (charge-format "%s/index.html" :slug)
     :emit (lambda (destination particle _route _site)
             (charge-write
              (charge-html `((h1 "this is a page!")
                             (body ,(alist-get :html particle))))
              destination)))

   (charge-route static-files
     :url (charge-format "%s" :filename)
     :path (charge-format "%s" :filename)
     :emit (lambda (destination particle _route _site)
             (copy-file (alist-get :path particle) destination t)))))

;;; charge-build.el ends here
