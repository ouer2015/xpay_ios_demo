
Pod::Spec.new do |s|
  s.name         = 'XPay'
  s.version      = '1.1.05'
  s.summary      = 'XPay iOS SDK'
  s.description  = <<-DESC
                   旋涡科技支付组件,包含 支付宝、微信、百度钱包、银联。
                   DESC
  s.homepage     = 'http://www.kkkd.com/home'
  s.license      = 'MIT'
  s.author       = { 'tongxuan' => 'tongxuan@ixiaopu.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/ouer2015/xpay_ios_demo.git', :tag => s.version }
  s.requires_arc = true
  s.default_subspec = 'Base', 'AliPay', 'WxPay', 'UnionPay'

  s.subspec 'Base' do |base|
    base.source_files = 'example/sdk/*.h'
    base.public_header_files = 'example/sdk/*.h'
    base.vendored_libraries = 'example/sdk/*.a'
    base.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security', 'ImageIO', 'MobileCoreServices', 'CoreTelephony'
    base.ios.library = 'c++', 'stdc++', 'z'
    base.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  end

  s.subspec 'AliPay' do |alipay|
    alipay.vendored_libraries = 'example/sdk/Channel/Alipay/*.a'
    alipay.ios.vendored_frameworks = 'example/sdk/Channel/Alipay/AlipaySDK.framework'
    alipay.resource = 'example/sdk/Channel/Alipay/AlipaySDK.bundle'
    alipay.dependency 'XPay/Base'
  end

  s.subspec 'WxPay' do |wx|
    wx.vendored_libraries = 'example/sdk/Channel/WxPay/*.a'
    wx.public_header_files = 'example/sdk/Channel/WxPay/*.h'
    wx.source_files = 'example/sdk/Channel/WxPay/*.h'
    wx.ios.library = 'sqlite3'
    wx.dependency 'XPay/Base'
  end

  s.subspec 'UnionPay' do |unionpay|
    unionpay.vendored_libraries = 'example/sdk/Channel/UnionPay/*.a'
    unionpay.public_header_files = 'example/sdk/Channel/UnionPay/*.h'
    unionpay.source_files = 'example/sdk/Channel/UnionPay/*.h'
    unionpay.dependency 'XPay/Base'
  end

  s.subspec 'Bfb' do |bfb|
    bfb.frameworks = 'AddressBook', 'AddressBookUI', 'AudioToolbox', 'CoreAudio', 'CoreGraphics', 'MapKit', 'MessageUI', 'QuartzCore'
    bfb.public_header_files = 'example/sdk/Channel/BfbPay/Library/**/*.h'
    bfb.source_files = 'example/sdk/Channel/BfbPay/Library/**/*.h'
    bfb.resource = 'example/sdk/Channel/BfbPay/*.bundle'
    bfb.vendored_libraries = 'example/sdk/Channel/BfbPay/**/*.a'
    bfb.dependency 'XPay/Base'
  end

end
