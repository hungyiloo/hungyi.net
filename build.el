;;; build.el --- builds my static blog using charge.el -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;; builds my static blog using charge.el
;;;
;;; Code:
(unless (bound-and-true-p doom-init-p)
  (load-file "~/.config/emacs/early-init.el")
  (load-file "~/.config/emacs/init.el"))

(require 'charge)

;; Enable syntax highlighting using tree-sitter
(require 'tree-sitter)
(require 'tree-sitter-langs)
(unless global-tree-sitter-mode
  (global-tree-sitter-mode 1))

;; Load templates
(mapc (lambda (template) (load-file template)) (file-expand-wildcards "templates/*.el"))
(declare-function my/blog/render-base ())
(declare-function my/blog/template-blog-index ())
(declare-function my/blog/template-post ())
(declare-function my/blog/template-post-meta ())
(declare-function my/blog/template-page ())

;; Collect particles from various data sources
;; Data sources can be transformed to particles by any means
(let* ((posts        (charge-collect-org
                      (file-expand-wildcards "content/posts/*.org")))
       (pages        (charge-collect-org
                      (file-expand-wildcards "content/*.org")))
       (static-files (charge-collect-files
                      (file-expand-wildcards "static/*")))
       ;; This item is an example of a manually constructed particle
       (blog-index   (charge-particle "blog-index"
                       ;; Any key-value pairs can go in this plist.
                       ;; Whatever is meaninful to you, as long as the emitter
                       ;; lambda in your route understands what to do with it
                       :posts posts)))

  ;; Setup and render the site
  (charge-site
   :name "Hung-Yi’s Journal"
   :base-url (cond ((getenv "PRODUCTION") "https://hungyi.net/")
                   (t "http://localhost:5000/"))
   :output "output" ; where all the output files go

   ;; More key-value pairs can be added here; whatever you want.
   ;; They'll end up as a `site' plist inside the emitter lambdas.
   ;; Useful for side-wide variables and properties.

   ;; Each route takes either a single particle or list of particles
   (charge-route posts
     ;; Each particle in the route is mapped to a single canonical URL
     :url (charge-format "posts/%s" :slug)
     ;; Each particle is emitted to a destination path
     :path (charge-format "posts/%s/index.html" :slug)
     ;; Each particle has its own method of emission
     ;; In this case, we write some HTML to the destination path
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/template-post particle (charge-export-particle-org particle))
               (plist-get particle :title)
               (my/blog/template-post-meta particle site))
              destination)))

   (charge-route blog-index
     :url ""
     :path '("index.html" "posts/index.html")
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/template-blog-index (plist-get particle :posts) site))
              destination)))

   (charge-route pages
     :url (charge-format "%s" :slug)
     :path (charge-format "%s/index.html" :slug)
     :emit (lambda (destination particle _route site)
             (charge-write
              (my/blog/render-base
               site
               (my/blog/template-page particle (charge-export-particle-org particle))
               (plist-get particle :title))
              destination)))

   (charge-route static-files
     :url (charge-format "%s" :filename)
     :path (charge-format "%s" :filename)
     :emit (lambda (destination particle _route _site)
             ;; Something different here --- we copy the file to the destination
             (copy-file (plist-get particle :path) destination t)))))

(provide 'build)
;;; build.el ends here
