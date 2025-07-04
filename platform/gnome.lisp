
(in-package #:dev.shft.whallee)

(defclass gnome-platform (base-platform) ())

(defmethod detect-environment ((h gnome-platform))
  (and (uiop:os-unix-p)
	   (search "GNOME" (uiop:getenv "XDG_CURRENT_DESKTOP") :test #'string-equal)))

(defmethod set-wallpaper ((h gnome-platform) path &optional dark-path)
  (let ((uri (format nil "file://~a" (uiop:native-namestring (truename path)))))
	(uiop:run-program `("gsettings" "set" "org.gnome.desktop.background" "picture-uri" ,uri)) ;; TODO: Use dconf directly
	(when dark-path
	  (let ((dark-uri (format nil "file://~a" (uiop:native-namestring (truename dark-path)))))
		(uiop:run-program `("gsettings" "set" "org.gnome.desktop.background" "picture-uri" ,dark-uri))))))

;; (defun set-dconf (key value &key (schema "org.gnome.desktop.background"))
;;   "Set a dconf value through DBus"
;;   (let ((bus dbus:session-server-addresses)
;; 		(dconf-path (format nil "/~a/" (substitute #\/ #\. schema))))
;; 	(dbus:with-introspected-object (writer bus "/ca/desrt/dconf/Writer/user" "ca.desrt.dconf")
;; 	  (writer schema ))))
