Pod::Spec.new do |spec|

spec.name         = "ADXiluSDK"
spec.version      = "1.0.4"
spec.summary      = "ADXilu iOS SDK - 广告聚合SDK"

spec.description  = <<-DESC
ADXilu iOS SDK 是一个广告聚合SDK，支持多个主流广告平台，提供统一的广告接口。
DESC

spec.homepage     = "https://github.com/xiluProject/XiluSdk_ios_pod"
spec.license      = "MIT"
spec.platform     = :ios, "12.2"
spec.ios.deployment_target = '12.2'
spec.author      = { 'Sagan' => 'sagan@xilu.com' }

spec.source       = { :git => "https://github.com/xiluProject/XiluSdk_ios_pod.git", :tag => "#{spec.version}" }

spec.frameworks = "UIKit", "Foundation", "AVFoundation", "CoreLocation", "SystemConfiguration", "AdSupport", "CoreTelephony"

spec.vendored_frameworks  = 'ADXiluSDK/ADXiluSDK.xcframework'
spec.swift_version = "5.6"

spec.dependency 'ObjectMapper'
spec.dependency 'CryptoSwift'

spec.dependency 'BeiZiSDK-iOS', '4.90.7.0'
spec.dependency 'MSMobAdSDK/MS', '2.7.7.3'

end
