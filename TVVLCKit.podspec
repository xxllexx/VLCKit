Pod::Spec.new do |s|
  s.name             = "TVVLCKit"
  s.version          = "3.0.0"
  s.summary          = "VLCKit (Used by PopcornTime)"
  s.homepage         = "https://github.com/PopcornTimeTV/VLCKit"
  s.license          = 'MIT'
  s.author           = { "Popcorn" => "popcorn@time.tv" }
  s.source           = { :http => "https://github.com/PopcornTimeTV/VLCKit/releases/download/3.0.0/TVVLCKit.framework.zip" }
  s.frameworks = 'QuartzCore', 'CoreText', 'AVFoundation', 'Security', 'CFNetwork', 'AudioToolbox', 'OpenGLES', 'CoreGraphics', 'VideoToolbox', 'CoreMedia'
  s.libraries = 'c++', 'xml2', 'z', 'bz2', 'iconv'
  s.requires_arc = false
  s.platform = :tvos
  s.tvos.deployment_target = '9.0'
  s.vendored_frameworks = "TVVLCKit.framework"
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++'
  }
end
