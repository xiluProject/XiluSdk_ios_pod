#
#  Be sure to run `pod spec lint ADXiluSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  These will help people to find your library, and whilst it
#  can feel like a chore to fill in it's definitely to your advantage. The
#  summary should be tweet-length, and the description more in depth.
#

spec.name         = "ADXiluSDK"
spec.version      = "1.0.0"
spec.summary      = "ADXilu iOS SDK - 广告聚合SDK"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
spec.description  = <<-DESC
ADXilu iOS SDK 是一个广告聚合SDK，支持多个主流广告平台，提供统一的广告接口。
DESC

spec.homepage     = "https://github.com/xiluProject/XiluSdk_ios_pod.git"
spec.license      = "MIT"
spec.platform     = :ios, "12.2"
spec.ios.deployment_target = '12.2'
spec.author      = { 'Sagan' => 'sagan@xilu.com' }

spec.source       = { :git => "https://github.com/xiluProject/XiluSdk_ios_pod.git", :tag => "#{spec.version}" }

spec.frameworks = "UIKit", "Foundation", "AVFoundation", "CoreLocation", "SystemConfiguration", "AdSupport", "CoreTelephony"

spec.vendored_frameworks  = 'ADXiluSDK/ADXiluSDK.framework'

# spec.libraries = "iconv", "xml2"
spec.swift_versions = ['5.0', '5.1', '5.2']

spec.dependency 'ObjectMapper'
spec.dependency 'CryptoSwift'

spec.dependency 'BeiZiSDK-iOS', '4.90.7.0'
spec.dependency 'MSMobAdSDK/MS', '2.7.7.3'

end
