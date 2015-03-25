Pod::Spec.new do |s|
  s.name             = "JRMPush"
  s.version          = "0.1.3"
  s.summary          = "Show a web page when a push is received with a URL in its metadata."
  s.homepage         = "https://github.com/davidolesch/JRMPush"
  s.screenshots      = "https://raw.githubusercontent.com/davidolesch/JRMPush/master/ClassAnnouncement.gif"
  s.license          = 'MIT'
  s.author           = { "David Olesch" => "david@jackrabbitmobile.com" }
  s.source           = { :git => "https://github.com/davidolesch/JRMPush.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/davidolesch'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{h,m}'

  s.public_header_files = 'Pod/Classes/*.h'
  s.dependency 'SVWebViewController', '~> 1.0'
end
