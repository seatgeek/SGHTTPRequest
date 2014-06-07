Pod::Spec.new do |s|
  s.name          = "SGHTTPRequest"
  s.version       = "1.0.0"
  s.summary       = "A lightweight AFNetworking wrapper for making HTTP requests with minimal code, and callback blocks for success, failure, and retry."
  s.homepage      = "https://github.com/seatgeek/SGHTTPRequest"
  s.license       = { :type => "BSD", :file => "LICENSE" }
  s.author        = "SeatGeek"
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/seatgeek/SGHTTPRequest.git", :tag => "1.0.0" }
  s.source_files  = "*.{h,m}"
  s.requires_arc = true  
  s.dependency    "AFNetworking"
end
