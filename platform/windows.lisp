
(in-package #:dev.shft.whallee)

(defclass windows-platform (base-platform) ())

;;; TODO: Test this 

(defmethod detect-environment ((h windows-platform))
  (uiop:os-windows-p))

(defconstant SPI_SETDESKWALLPAPER #x0014)

(cffi:defctype lpcwstr :pointer)
(cffi:defctype hresult :unsigned-char)

(cffi:defcfun ("SetWallpaper" win-set-wallpaper) hresult
  (monitor-id lpcwstr)
  (wallpaper lpcwstr))

(defmethod set-wallpaper ((h windows-platform) path &optional dark-path)
  (declare (ignore dark-path))
  (unless (= (win-set-wallpaper nil (uiop:native-namestring (truename path)))
	 0)
	  (error "Error setting windows wallpaper")))
