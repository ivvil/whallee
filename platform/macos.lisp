
(in-package #:dev.shft.whallee)

(defclass macos-platform (base-platform) ())

;;; TODO: Test this on macos 

(defmethod detect-environment ((h macos-platform))
  (uiop:os-macosx-p))

(defmethod set-wallpaper ((h macos-platform) path &optional dark-path)
  (declare (ignore dark-path))
  (let ((script (format nil "tell application \"Finder\" to set desktop picture to POSIX file \"~a\"" (uiop:native-namestring (truename path)))))
	(uiop:run-program `("osascript" "-e" ,script))))
