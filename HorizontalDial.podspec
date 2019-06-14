Pod::Spec.new do |s|
  s.name         = "HorizontalDial"
  s.version      = "4.0"
  s.summary      = "A horizontal scroll dial like Instagram"
  s.homepage     = "https://github.com/kciter/KCHorizontalDial"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "kciter" => "kciter@naver.com" }
  s.source       = { :git => "https://github.com/kciter/HorizontalDial.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'HorizontalDial/*.{swift}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
