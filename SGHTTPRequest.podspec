Pod::Spec.new do |s|
  s.name          = "SGHTTPRequest"
  s.version       = "1.8.3"
  s.summary       = "A lightweight AFNetworking wrapper for making HTTP requests with minimal code, and callback blocks for success, failure, and retry."
  s.homepage      = "https://github.com/seatgeek/SGHTTPRequest"
  s.license       = { :type => "BSD", :file => "LICENSE" }
  s.author        = "SeatGeek"    
  s.source        = { :git => "https://github.com/seatgeek/SGHTTPRequest.git", :tag => "1.8.3" }
  s.requires_arc  = true
  s.dependency    "AFNetworking", '~>3.0'
  s.dependency    "MGEvents", '~> 1.1'
  s.default_subspecs = 'Core', 'UIKit'
  s.ios.deployment_target = '7.0'
  s.subspec 'Core' do |sp|
    sp.ios.deployment_target = '7.0'
    sp.watchos.deployment_target = '2.0'
    sp.source_files = 'SGHTTPRequest/Core/**/*.{h,m}'    
  end

  s.subspec 'UIKit' do |sp|    
    sp.ios.deployment_target = '7.0'
    sp.xcconfig = { "GCC_PREPROCESSOR_DEFINITIONS" => '$(inherited) SG_INCLUDE_UIKIT=1' }
    sp.dependency 'SGHTTPRequest/Core'    
    sp.source_files = 'SGHTTPRequest/UI/**/*.{h,m}'
  end

end
