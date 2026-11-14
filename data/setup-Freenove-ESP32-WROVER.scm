;;; Copyright 2026 by Frobenius Norm LLC 2026-09-25
(syslog "Target: Freenove-ESP32-WROVER -- OV2640 camera node\n")
(define wrover-camera-ok
  (guard (e (#t (syslog "[wrover] camera-init raised -- continuing without a camera\n") #f))
    (camera-init 'jpeg (setting 'cam_size (string->symbol "240")))))
(syslog "[wrover] camera ~a at ~a\n"
        (if wrover-camera-ok "ready (jpeg)" "NOT available")
        (setting 'cam_size (string->symbol "240")))
(define (wrover-cam-tune! key skey)
  (let ((v (setting skey 'unset)))
    (if (eq? v 'unset)
        #f
        (begin (syslog "[wrover] camera-set ~a ~a -> ~a\n" key v (camera-set key v)) #t))))
(when wrover-camera-ok
  (wrover-cam-tune! 'gainceiling   'cam_gainceiling)
  (wrover-cam-tune! 'aec2          'cam_aec2)
  (wrover-cam-tune! 'ae-level      'cam_ae_level)
  (wrover-cam-tune! 'exposure-ctrl 'cam_exposure_ctrl)
  (wrover-cam-tune! 'aec-value     'cam_aec_value)
  (wrover-cam-tune! 'gain-ctrl     'cam_gain_ctrl)
  (wrover-cam-tune! 'agc-gain      'cam_agc_gain)
  (wrover-cam-tune! 'brightness    'cam_brightness)
  (wrover-cam-tune! 'contrast      'cam_contrast)
  (wrover-cam-tune! 'quality       'cam_quality)
  (wrover-cam-tune! 'vflip         'cam_vflip)
  (wrover-cam-tune! 'hmirror       'cam_hmirror))
