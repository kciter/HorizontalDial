Pod::Spec.new do |s|
  s.name         = "KCJogDial"
  s.version      = "1.0.2"
  s.summary      = "It is controllable UIView like Jog Dial"
  s.homepage     = "https://github.com/kciter/KCJogDial"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "kciter" => "kciter@naver.com" }
  s.source       = { :git => "https://github.com/kciter/KCJogDial.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'KCJogDial/*.{swift}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
