Pod::Spec.new do |s|
  s.name          = "SGHTTPRequest"
  s.version       = "1.7.0"
  s.summary       = "A lightweight AFNetworking wrapper for making HTTP requests with minimal code, and callback blocks for success, failure, and retry."
  s.homepage      = "https://github.com/seatgeek/SGHTTPRequest"
  s.license       = { :type => "BSD", :file => "LICENSE" }
  s.author        = "SeatGeek"
  s.watchos.deployment_target = '2.0'
  s.ios.deployment_target = '7.0'
  s.source        = { :git => "https://github.com/seatgeek/SGHTTPRequest.git", :tag => "1.6.0" }
  s.source_files = 'SGHTTPRequest/**/*.{h,m}'
  s.requires_arc  = true
  s.dependency    "AFNetworking", '~>3.0'
  s.dependency    "MGEvents/Core"
end
