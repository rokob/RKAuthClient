Pod::Spec.new do |s|
  s.name             = "RKAuthClient"
  s.version          = "0.0.3"
  s.summary          = "RKAuthClient - An Authorization Facade"
  s.description      = <<-DESC
                       =RKAuthClient

                       This is a library built to act as a facade between your application
                       and any number of possible backend authorization systems.
                       Write once against this API and then plug in whatever backend
                       adapter you wish to actually use. Decide to change your backend
                       and you only have to change a handful of lines rather than
                       your entire authorization logic.
                       DESC
  s.homepage         = "https://github.com/rokob/RKAuthClient"
  s.license          = 'MIT'
  s.author           = { "Andrew Ledvina" => "wvvwwvw@gmail.com" }
  s.source           = { :git => "https://github.com/rokob/RKAuthClient.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wolfgangfabian'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.public_header_files = 'RKAuthClient/RKAuthClient/**/*.h'
  s.source_files = 'RKAuthClient/RKAuthClient'

  s.subspec 'Firebase' do |ss|
    ss.dependency 'RKAuthClient/Core'
    ss.dependency 'Firebase', '~> 1.0.0'
    ss.frameworks = 'SystemConfiguration'
    ss.source_files = 'RKAuthClient/RKAuthClient/Firebase'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'RKAuthClient/RKAuthClient/RKAuthClient.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientBasicHandler.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientEmailHandler.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientFacebookHandler.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientTwitterHandler.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientTypes.{h,m}',
                      'RKAuthClient/RKAuthClient/RKAuthClientServices.h'
  end
end
