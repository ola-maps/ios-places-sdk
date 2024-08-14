Pod::Spec.new do |spec|
  spec.name          = 'OlaMapServices'
  spec.version       = '1.0.1'
  spec.summary       = 'OlaMap Places Service'
  spec.description   = 'This iOS SDK is designed to be robust, user-friendly, and easy to integrate into any application. By providing powerful features like Autocomplete, Forward Geocoding, Reverse Geocoding and NearbySearch, along with capabilities like configurable retry logic and automatic token refresh, this SDK is a comprehensive solution for place-related functionalities.'
  spec.homepage      = 'https://maps.olakrutrim.com/'
  spec.author        = { 'OlaMaps Team' => 'support@olamaps.io' }
  spec.license       = { :type => 'Copyright', :file => 'LICENSE' }
  spec.source        = { :git => 'https://github.com/ola-maps/ios-places-sdk.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '13.0'
  spec.ios.vendored_frameworks = "Frameworks/OlaMapServices.xcframework"

end
