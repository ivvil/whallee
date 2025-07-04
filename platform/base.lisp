
(in-package #:dev.shft.whallee)

(defclass base-platform () ())

(defgeneric set-wallpaper (handler path &optional dark-path)
  (:documentation "Set wallpaper"))

(defgeneric detect-environment (handler)
  (:documentation "Return T if handler matches current environment"))

(defgeneric prefered-color (handler)
  (:documentation "Returns :light if the prefered platform color is light, :dark if it's dark"))

(defgeneric register-theme-change-callback (handler callback-fn)
  (:documentation "Register function to call when system theme changes"))

(defvar *platform-classes* '(windows-platform macos-platform xdg-portal-platform gnome-platform))

(defun detect-platform ()
  (loop for class-name in *platform-classes*
        for class = (find-class class-name nil)
        when class
		  do (let ((platform-instance (make-instance class-name)))
			   (when (detect-environment platform-instance)
				 (return platform-instance)))
		finally (error "No compatible platform found")))
