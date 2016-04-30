Pod::Spec.new do |s|

  s.name         = 'SMAUpdatesAvailable'
  s.version      = '1.0'
  s.summary      = 'An easy to use library to check if there are iOS updates available for your application.'

  s.homepage     = 'https://github.com/simplymadeapps/SMAUpdatesAvailable'
  s.license      = 'MIT'
  s.author       = { 'Bill Burgess' => 'bill@simplymadeapps.com' }

  s.ios.deployment_target = '8.0'
  #s.osx.deployment_target = '10.9'
  #s.watchos.deployment_target = '2.0'
  #s.tvos.deployment_target = '9.0'

  s.source       = { :git => 'https://github.com/simplymadeapps/SMAUpdatesAvailable.git', :tag => s.version }
  s.source_files  = 'SMAUpdatesAvailable/*.{h,m}'
  s.requires_arc = true

end
