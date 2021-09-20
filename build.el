;;; publish.el --- Generate a simple static HTML blog
;;; Commentary:
;;
;;    Define the routes of the static website.  Each of which
;;    containing the pattern for finding Org-Mode files, which HTML
;;    template to be used, as well as their output path and URL.
;;
;;; Code:

;; (add-to-list 'load-path "~/.config/emacs/.local/straight/repos/weblorg")
;; (add-to-list 'load-path "~/.config/emacs/.local/straight/repos/templatel")
;; (add-to-list 'load-path "~/.config/emacs/.local/straight/repos/emacs-htmlize")
;; (add-to-list 'load-path "~/.config/emacs/.local/straight/repos/typescript.el")
(load-file "~/.config/emacs/early-init.el")
(load-file "~/.config/emacs/init.el")

(require 'weblorg)
(require 'htmlize)
(require 'typescript-mode)

(setq org-html-htmlize-output-type 'css)
(setq-default weblorg-default-url "")

(weblorg-site
 :theme nil)

;; Generate blog posts
(weblorg-route
 :name "posts"
 :input-pattern "content/posts/*.org"
 :template "post.html"
 :output "public/posts/{{ slug }}/index.html"
 :url "/posts/{{ slug }}")

;; Generate pages
(weblorg-route
 :name "pages"
 :input-pattern "content/*.org"
 :template "page.html"
 :output "public/{{ slug }}/index.html"
 :url "/{{ slug }}")

;; Generate posts summary
(weblorg-route
 :name "index"
 :input-pattern "content/posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog.html"
 :output "public/index.html"
 :url "/")

(weblorg-copy-static
 :output "public/{{ file }}"
 :url "/{{ file }}")

(weblorg-export)
;;; publish.el ends here
