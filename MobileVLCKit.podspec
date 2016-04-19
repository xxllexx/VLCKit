Pod::Spec.new do |s|
  s.name             = "MobileVLCKit"
  s.version          = "3.0.0"
  s.summary          = "VLCKit (Used by PopcornTime)"
  s.homepage         = "https://github.com/PopcornTimeTV/VLCKit"
  s.license          = 'MIT'
  s.author           = { "Popcorn" => "popcorn@time.tv" }
  s.source           = { :http => "https://github.com/PopcornTimeTV/VLCKit/releases/download/1.0.0/TVVLCKit.framework.zip" }
  s.requires_arc = true
  s.platform = :tvos
  s.tvos.deployment_target = '9.0'
  s.vendored_frameworks = "TVVLCKit.framework"
end
