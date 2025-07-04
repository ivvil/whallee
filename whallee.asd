;;;; whallee.asd

(asdf:defsystem #:whallee
  :description "Multiplatform wallpaper manager"
  :author "Iván Villagrasa <ivvil412@gmail.com>"
  :license  "GPL-3.0"
  :version "0.0.1"
  :serial t
  :depends-on (:dbus)
  :components ((:file "package")
               (:file "whallee")
			   (:module "platform"
				:components ((:file "base")
							 (:file "gnome")
							 (:file "macos")
							 (:file "windows")
							 (:file "xdg-portal")))))
