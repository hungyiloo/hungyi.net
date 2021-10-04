;;; charge-build.el --- builds my static blog using charge.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(let ((posts (charge-collect-nodes-org (file-expand-wildcards "content/posts/*.org")))
      (pages (charge-collect-nodes-org (file-expand-wildcards "content/*.org")))
      (static-files (file-expand-wildcards "theme/static/*")))
  (charge-site
   :base-url "http://localhost:5000/"
   :output-dir "output"

   :routes
   `((:url ,(lambda (node) (format "posts/%s" (alist-get :slug node)))
      :output ,(lambda (node) (format "posts/%s/index.html" (alist-get :slug node)))
      :nodes ,posts
      :writer ,(lambda (destination node _route _site)
                 (write-region
                  (charge-render `(body ,(charge-export-node-org node)))
                  nil
                  destination)))

     (:url ,(lambda (node) (alist-get :slug node))
      :output ,(lambda (node) (format "%s/index.html" (alist-get :slug node)))
      :nodes ,pages
      :writer ,(lambda (destination node _route _site)
                 (write-region
                  (charge-render `((h1 "this is a page!")
                                   (body ,(alist-get :html node))))
                  nil
                  destination)))

     (:url ,(lambda (node) (file-name-nondirectory node))
      :output ,(lambda (node) (file-name-nondirectory node))
      :nodes ,static-files
      :writer ,(lambda (destination node _route _site)
                 (copy-file node destination))))))

;;; charge-build.el ends here
