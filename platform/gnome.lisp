
(in-package #:dev.shft.whallee)

(defclass gnome-platform (base-platform) ())

(defmethod detect-environment ((h gnome-platform))
  (and (uiop:os-unix-p)
	   (search "GNOME" (uiop:getenv "XDG_CURRENT_DESKTOP") :test #'string-equal)))

(defmethod set-wallpaper ((h gnome-platform) path &optional dark-path)
  (let ))

(defun set-dconf (key value &key (schema "org.gnome.desktop.background"))
  "Set a dconf value through DBus"
  (let* ))
