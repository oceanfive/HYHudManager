
Pod::Spec.new do |s|
  s.name             = 'HYHudManager'
  s.version          = '0.0.1'
  s.summary          = 'HUD的二次封装'
  s.description      = <<-DESC
对 MBProgressHUD 和 SVProgressHUD 的二次封装
                       DESC
  s.homepage         = 'https://github.com/oceanfive/HYHudManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oceanfive' => '849638313@qq.com' }
  s.source           = { :git => 'https://github.com/oceanfive/HYHudManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'HYHudManager/Classes/**/*'
  s.dependency 'MBProgressHUD', '~> 1.0.0'
  s.dependency 'SVProgressHUD', '~> 2.1.0'
end
