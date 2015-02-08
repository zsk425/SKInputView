Pod::Spec.new do |s|

  s.name         = "SKInputView"
  s.version      = "0.0.1"
  s.summary      = "A compose bar likes the one in iOS7 Messages.app"

  s.description  = <<-DESC
                   SKInputView is a compose bar likes the one in iOS7 Messages.app.It is inspired by PHFComposeBarView which has some issues on iOS8 and has not updated for a log time. 
                   DESC

  s.homepage      = "https://github.com/zsk425/SKInputView"
  s.license       = "MIT"
  s.author        = { "Shaokang Zhao" => "zsk425@hotmail.com" }
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/zsk425/SKInputView.git", :tag => "0.0.1" }
  s.source_files  = "SKInputView/*.{h,m}"
  s.resource      = "SKInputView/*.xib"
  s.frameworks    = "UIKit", "Foundation" 
  s.requires_arc  = true

end
