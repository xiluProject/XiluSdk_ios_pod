# ADXiluSdk - 聚合广告SDK

ADXiluSdk是一个支持多平台广告聚合的iOS SDK，提供统一的API接口，支持MSMobAdSDK和BeiZiSDK的集成。支持Objective-C和Swift/SwiftUI项目。

## 特性

- 🚀 **多平台支持**: 集成MSMobAdSDK和BeiZiSDK
- 📱 **iOS兼容**: 最低支持iOS 12.2，兼容新老系统API
- 🔧 **组件化架构**: 模块化设计，易于扩展和维护
- 🎯 **统一接口**: 提供一致的API，简化多平台广告管理
- 💻 **多语言支持**: 支持Objective-C和Swift
- 📊 **完整回调**: 提供加载、展示、点击、关闭等完整事件回调
- 🛠 **易于集成**: 通过CocoaPods简单集成

## 支持的广告类型

- **横幅广告** (Banner Ad)
- **插屏广告** (Interstitial Ad)  
- **激励视频广告** (Reward Video Ad)
- **原生广告** (Native Ad)
- **开屏广告** (Splash Ad)
- **全屏视频广告** (Full Screen Video Ad)
- **Draw视频信息流** (Draw Video Feed Ad)

## 支持的广告平台

- **MSMobAdSDK**: 美数广告平台
- **BeiZiSDK**: 贝子广告平台
- **自动选择**: 根据配置自动选择最优平台

## 系统要求

- iOS 12.2+
- Xcode 12.0+
- Swift 5.0+
- CocoaPods 1.10.0+

## 安装

### 使用CocoaPods

1. 在您的`Podfile`中添加：

```ruby
platform :ios, '12.2'

target 'YourApp' do
  use_frameworks!
  
  # 使用远程版本
  pod 'ADXiluSdk', '~> 1.0.0'
end
```

2. 运行安装命令：

```bash
pod install
```

3. 打开生成的`.xcworkspace`文件

## 快速开始

### 1. 初始化SDK

#### Objective-C

```objc
#import <ADXiluSdk/ADXiluSdk.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[ADXiluSdk shared] initializeWithAppId:@"your_app_id" 
                                     debug:YES 
                                 completion:^(BOOL success, NSString * _Nullable error) {
        if (success) {
            NSLog(@"ADXiluSdk initialized successfully");
        } else {
            NSLog(@"ADXiluSdk initialization failed: %@", error);
        }
    }];
    return YES;
}
```

#### Swift

```swift
import ADXiluSdk

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ADXiluSdk.shared.initialize(appId: "your_app_id", debug: true) { success, error in
        if success {
            print("ADXiluSdk initialized successfully")
        } else {
            print("ADXiluSdk initialization failed: \(error ?? "Unknown error")")
        }
    }
    return true
}
```

### 2. 加载和展示广告

#### 横幅广告

```swift
import ADXiluSdk

class BannerAdViewController: UIViewController {
    private var bannerAd: ADXiluBannerAd?
    private var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func loadBannerAd() {
        guard ADXiluSdk.shared.isInitialized else {
            print("SDK未初始化")
            return
        }
        
        // 创建Banner广告
        let adSize = ADXiluAdSize(width: UIScreen.main.bounds.width, height: 60)
        bannerAd = ADXiluBannerAd(adPosId: "your_banner_ad_pos_id", adSize: adSize)
        bannerAd?.showCloseBtn = true
        bannerAd?.containerView = containerView
        bannerAd?.nativeViewController = self
        bannerAd?.delegate = self
        bannerAd?.autoRefreshInterval = 5
        
        bannerAd?.loadAd()
    }
}

// 实现代理方法
extension BannerAdViewController: ADXiluBaseAdDelegate {
    func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("Banner广告加载成功 - \(adInfo.platform.name)")
    }
    
    func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) {
        print("Banner广告加载失败: \(error.message)")
    }
    
    func xilu_AdDidClick(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("Banner广告被点击")
    }
    
    func xilu_AdDidClose(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("Banner广告已关闭")
    }
}
```

#### 插屏广告

```swift
class InterstitialAdViewController: UIViewController {
    private var interstitialAd: ADXiluInterstitialAd?
    
    private func loadInterstitialAd() {
        guard ADXiluSdk.shared.isInitialized else {
            print("SDK未初始化")
            return
        }
        
        // 创建插屏广告
        let adSize = ADXiluAdSize(width: UIScreen.main.bounds.width, height: 300)
        interstitialAd = ADXiluInterstitialAd(adPosId: "your_interstitial_ad_pos_id", 
                                             adSize: adSize, 
                                             rootVC: self)
        interstitialAd?.delegate = self
        
        interstitialAd?.loadAd()
    }
    
    private func showInterstitialAd() {
        interstitialAd?.showAd(from: self)
    }
}

extension InterstitialAdViewController: ADXiluBaseAdDelegate {
    func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("插屏广告加载成功")
        // 可以展示广告
        showInterstitialAd()
    }
    
    func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) {
        print("插屏广告加载失败: \(error.message)")
    }
    
    func xilu_AdDidClose(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("插屏广告已关闭")
    }
}
```

#### 激励视频广告

```swift
class RewardVodAdViewController: UIViewController {
    private var rewardVodAd: ADXiluRewardVodAd?
    
    private func loadRewardVodAd() {
        guard ADXiluSdk.shared.isInitialized else {
            print("SDK未初始化")
            return
        }
        
        // 创建激励视频广告
        rewardVodAd = ADXiluRewardVodAd(adPosId: "your_reward_vod_ad_pos_id")
        rewardVodAd?.delegate = self
        rewardVodAd?.videoDelegate = self
        rewardVodAd?.isMuted = false
        
        rewardVodAd?.loadAd()
    }
    
    private func showRewardVodAd() {
        rewardVodAd?.showAd(from: self)
    }
}

extension RewardVodAdViewController: ADXiluBaseAdDelegate {
    func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("激励视频广告加载成功")
        // 可以展示广告
        showRewardVodAd()
    }
    
    func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) {
        print("激励视频广告加载失败: \(error.message)")
    }
}

extension RewardVodAdViewController: ADXiluRewardVodAdDelegate {
    func xilu_AdDidReward(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("获得奖励: \(adInfo.rewardAmount) \(adInfo.rewardName)")
    }
    
    func xilu_AdVideoDidComplete(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("视频播放完成")
    }
}
```

#### 开屏广告

```swift
class SplashAdViewController: UIViewController {
    private var splashAd: ADXiluSplashAd?
    
    private func loadSplashAd() {
        guard ADXiluSdk.shared.isInitialized else {
            print("SDK未初始化")
            return
        }
        
        // 创建开屏广告
        let adSize = ADXiluAdSize(width: UIScreen.main.bounds.width, height: 300)
        splashAd = ADXiluSplashAd(adPosId: "your_splash_ad_pos_id", 
                                 style: .halfScreen, 
                                 adSize: adSize)
        splashAd?.delegate = self
        splashAd?.countdownDuration = 5.0
        
        splashAd?.loadAd()
    }
    
    private func showSplashAd() {
        splashAd?.showAd()
    }
}

extension SplashAdViewController: ADXiluBaseAdDelegate {
    func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) {
        print("开屏广告加载成功")
        // 可以展示广告
        showSplashAd()
    }
    
    func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) {
        print("开屏广告加载失败: \(error.message)")
    }
    
    func xilu_AdTick(_ xiluAd: ADXiluBaseAd, remainingTime: TimeInterval) {
        print("倒计时: \(Int(remainingTime))s")
    }
}
```

#### 原生广告

```swift
class NativeAdViewController: UIViewController {
    private var nativeAd: ADXiluNativeAd?
    
    private func loadNativeAd() {
        guard ADXiluSdk.shared.isInitialized else {
            print("SDK未初始化")
            return
        }
        
        // 创建原生广告
        let adSize = ADXiluAdSize(width: UIScreen.main.bounds.width, height: 300)
        nativeAd = ADXiluNativeAd(adPosId: "your_native_ad_pos_id", 
                                  adSize: adSize, 
                                  count: 3)
        nativeAd?.nativeViewController = self
        nativeAd?.delegate = self
        
        nativeAd?.loadAd()
    }
}

extension NativeAdViewController: ADXiluBaseAdDelegate {
    func xilu_AdDidReceiveMuti(_ xiluAd: ADXiluBaseAd, adInfos: [ADXiluAdInfo]) {
        print("原生广告加载成功，数量: \(adInfos.count)")
        
        for adInfo in adInfos {
            if let adView = adInfo.extraData["nativeAdView"] as? UIView {
                // 将广告视图添加到界面中
                view.addSubview(adView)
            }
        }
    }
    
    func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) {
        print("原生广告加载失败: \(error.message)")
    }
}
```

## API参考

### 核心类

#### ADXiluSdk

主要的SDK管理类，提供统一的广告管理接口。

**主要方法：**

- `initialize(appId:debug:completion:)` - 初始化SDK
- `isInitialized` - 是否已初始化
- `getVersion()` - 获取SDK版本
- `getAdsConfig()` - 获取广告配置

#### ADXiluBaseAd

广告基类，所有广告类型的父类。

**属性：**

- `adPosId: String` - 广告位ID
- `adSize: ADXiluAdSize` - 广告尺寸
- `delegate: ADXiluBaseAdDelegate?` - 代理
- `countdownDuration: TimeInterval` - 倒计时时长

**方法：**

- `loadAd()` - 加载广告
- `showAd(in:)` - 展示广告

#### ADXiluAdSize

广告尺寸类。

**属性：**

- `width: CGFloat` - 宽度
- `height: CGFloat` - 高度

**静态方法：**

- `screenWidth` - 屏幕宽度
- `screenSize` - 屏幕尺寸

#### ADXiluAdInfo

广告信息类。

**属性：**

- `adId: String` - 广告ID
- `platform: ADXiluAdPlatform` - 广告平台
- `isReady: Bool` - 是否准备就绪
- `rewardAmount: Int` - 奖励数量
- `rewardName: String` - 奖励名称
- `extraData: [String: Any]` - 额外数据

### 广告类型

#### ADXiluBannerAd

横幅广告类。

**属性：**

- `showCloseBtn: Bool` - 是否显示关闭按钮
- `containerView: UIView?` - 容器视图
- `autoRefreshInterval: Int` - 自动刷新间隔

#### ADXiluInterstitialAd

插屏广告类。

**初始化方法：**

- `init(adPosId:adSize:rootVC:)` - 初始化插屏广告

#### ADXiluRewardVodAd

激励视频广告类。

**属性：**

- `isMuted: Bool` - 是否静音
- `videoDelegate: ADXiluRewardVodAdDelegate?` - 视频代理

#### ADXiluSplashAd

开屏广告类。

**初始化方法：**

- `init(adPosId:style:adSize:)` - 初始化开屏广告

**属性：**

- `bottomView: UIView?` - 底部视图

#### ADXiluNativeAd

原生广告类。

**初始化方法：**

- `init(adPosId:adSize:count:)` - 初始化原生广告

**属性：**

- `nativeViewController: UIViewController?` - 原生视图控制器

### 代理协议

#### ADXiluBaseAdDelegate

广告事件代理协议。

**方法：**

- `xilu_AdDidReceive(_:adInfo:)` - 广告接收成功
- `xilu_AdDidReceiveMuti(_:adInfos:)` - 多个广告接收成功
- `xilu_AdDidExpose(_:adInfo:)` - 广告曝光
- `xilu_AdDidClick(_:adInfo:)` - 广告点击
- `xilu_AdDidClose(_:adInfo:)` - 广告关闭
- `xilu_AdDidSkip(_:adInfo:)` - 广告跳过
- `xilu_AdDidFail(_:error:)` - 广告加载失败
- `xilu_AdTick(_:remainingTime:)` - 倒计时回调

#### ADXiluRewardVodAdDelegate

激励视频广告专用代理协议。

**方法：**

- `xilu_AdVideoDidCache(_:adInfo:)` - 视频缓存完成
- `xilu_AdVideoDidComplete(_:adInfo:)` - 视频播放完成
- `xilu_AdVideoDidError(_:adInfo:error:)` - 视频播放错误
- `xilu_AdDidReward(_:adInfo:)` - 获得奖励

## 配置

### 初始化配置

```swift
// 初始化时设置调试模式
ADXiluSdk.shared.initialize(appId: "your_app_id", debug: true) { success, error in
    if success {
        print("SDK初始化成功")
    } else {
        print("SDK初始化失败: \(error ?? "")")
    }
}
```

### 广告位配置

SDK支持通过服务器配置广告位信息，包括：
- 广告位ID映射
- 平台优先级
- 广告尺寸配置
- 超时时间设置

## 示例项目

项目包含完整的示例应用，展示了各种广告类型的使用方法：

1. 克隆项目
2. 运行 `pod install`
3. 打开 `SwiftDemo.xcworkspace`
4. 运行示例应用

示例项目包含以下功能：
- 开屏广告演示
- 插屏广告演示
- 激励视频广告演示
- 原生广告演示
- Banner广告演示
- 完整的代理回调处理

## 架构设计

ADXiluSdk采用组件化架构设计：

```
ADXiluSdk/
├── Core/                    # 核心模块
│   ├── ADXiluSdk.swift     # 主管理类
│   ├── ADXiluBaseAd.swift  # 广告基类
│   ├── ADAdaptor.swift     # 适配器管理
│   └── ADNetworkTool.swift # 网络工具
├── Ads/                    # 广告模块
│   ├── ADXiluBannerAd.swift      # 横幅广告
│   ├── ADXiluInterstitialAd.swift # 插屏广告
│   ├── ADXiluRewardVodAd.swift   # 激励视频广告
│   ├── ADXiluSplashAd.swift      # 开屏广告
│   └── ADXiluNativeAd.swift     # 原生广告
├── BeiZi/                  # BeiZiSDK适配器
├── MSMob/                  # MSMobAdSDK适配器
├── Extensions/              # 扩展模块
└── Tool/                   # 工具模块
    ├── ADDeviceInfoTool.swift    # 设备信息工具
    └── XLSDKLogTool.swift        # 日志工具
```

## 许可证

MIT License

## 支持

如有问题或建议，请联系：

- 邮箱: support@xilu.com
- 文档: https://github.com/xilu/ADXiluSdk-iOS
- 问题反馈: https://github.com/xilu/ADXiluSdk-iOS/issues

## 更新日志

### v1.0.0 (2025-10-27)
- 初始版本发布
- 支持MSMobAdSDK和BeiZiSDK集成
- 提供完整的广告类型支持
- 支持Objective-C和Swift
- 最低支持iOS 12.2
- 包含完整的示例项目
