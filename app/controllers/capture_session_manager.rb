class CaptureSessionManager < NSObject
  attr_accessor :captureSession, :previewLayer
  
  def init
    super
    self.setCaptureSession AVCaptureSession.alloc.init
    self
  end

  def addVideoPreviewLayer
    self.setPreviewLayer AVCaptureVideoPreviewLayer.alloc.initWithSession(self.captureSession)
    self.previewLayer.setVideoGravity AVLayerVideoGravityResizeAspectFill
  end
  
  def addVideoInput
    videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if videoDevice
      error = Pointer.new('@')
      videoIn = AVCaptureDeviceInput.deviceInputWithDevice(videoDevice, error:error)
      if !error[0]
        if self.captureSession.canAddInput(videoIn)
          self.captureSession.addInput(videoIn);
        else
          NSLog "Couldn't add video input";    
        end
      else
        NSLog "Couldn't create video input: " + error
      end
    else
      NSLog "Couldn't create video capture device"
    end
  end
  
end
