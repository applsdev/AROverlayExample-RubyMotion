class CameraController < UIViewController
  attr_accessor :captureManager, :scanningLabel

  def init
    super
  end

  def viewDidLoad
    self.view.backgroundColor = UIColor.lightGrayColor
    self.setCaptureManager CaptureSessionManager.alloc.init.autorelease
    self.captureManager.addVideoInput
    self.captureManager.addVideoPreviewLayer
    layerRect = self.view.layer.bounds
    self.captureManager.previewLayer.setBounds layerRect
    self.captureManager.previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(self.captureManager.previewLayer)
    overlayImageView = UIImageView.alloc.initWithImage(UIImage.imageNamed("overlaygraphic.png"))
    overlayImageView.frame = [[30, 100], [260, 200]]
    self.view.addSubview overlayImageView
    overlayButton = UIButton.buttonWithType UIButtonTypeCustom
    overlayButton.setImage(UIImage.imageNamed("scanbutton.png"), forState:UIControlStateNormal)
    overlayButton.setFrame(CGRectMake(130, 320, 60, 30))
    overlayButton.addTarget(self, action:'scanButtonPressed', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview overlayButton
    tempLabel = UILabel.alloc.initWithFrame(CGRectMake(100, 50, 120, 30))
    self.setScanningLabel(tempLabel)
    tempLabel.release
    scanningLabel.setBackgroundColor(UIColor.clearColor)
    scanningLabel.setFont(UIFont.fontWithName("Courier", size:18.0))
    scanningLabel.setTextColor(UIColor.redColor)
    scanningLabel.setText "Scanning..."
    scanningLabel.setHidden(true)
    self.view.addSubview scanningLabel
    captureManager.captureSession.startRunning
  end

  def scanButtonPressed
    self.scanningLabel.setHidden false
    self.performSelector("hideLabel:", withObject:self.scanningLabel, afterDelay:2)
  end
  
  def hideLabel(label)
    label.setHidden true
  end
  
end
