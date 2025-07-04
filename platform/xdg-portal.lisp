
(in-package #:dev.shft.whallee)

(defclass xdg-portal-platform (base-platform) ())

(defmethod detect-environment ((h xdg-portal-platform))
  (dbus:with-open-bus (bus (dbus:session-server-addresses))
	(find "org.freedesktop.portal.Desktop" (dbus:list-names bus) :test #'string-equal)))

(defmethod set-wallpaper ((h xdg-portal-platform) path &optional dark-path)
  (declare (ignore dark-path))
  (let ((uri (format nil "file://~a" (uiop:native-namestring (truename path)))))
	(dbus:with-open-bus (bus (dbus:session-server-addresses))
	  (dbus:with-introspected-object (wallpaper-set bus "/org/freedesktop/portal/desktop" "org.freedesktop.portal.Desktop")
		(wallpaper-set "org.freedesktop.portal.Wallpaper" "SetWallpaperURI"
					   "" uri '())))))
