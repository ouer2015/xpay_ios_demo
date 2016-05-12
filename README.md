# xpay_ios_demo
旋涡科技支付组件 
=================

****

## 版本要求

iOS SDK 要求 iOS 7.0 及以上版本

## 接入方法
### 安装

#### 手动导入
* 获取 SDK  
下载 SDK, 里面包含了 example 文件夹。example 文件夹里面是 SDK 的文件，以及一个示例demo。
* 依赖 Frameworks：

必需：

```
CFNetwork.framework
SystemConfiguration.framework
Security.framework
ImageIO.framework
MobileCoreServices.framework
CoreTelephony.framework
libc++.tbd
libz.tbd
libsqlite3.0.tbd
```

支付宝所需：

```
CoreMotion.framework
CoreText.framework
CoreGraphics.framework
```

百度钱包所需：

```
libstdc++.tbd
AddressBook.framework
AddressBookUI.framework
AudioToolbox.framework
CoreAudio.framework
CoreGraphics.framework
LocalAuthentication.framework
MessageUI.framework
QuartzCore.framework
CoreLocation.framework
```

* 如果不需要某些渠道，删除 `sdk/Channel` 下的相应目录即可。
* 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"。
* 添加 Other Linker Flags：在 Build Settings 搜索 Other Linker Flags ，添加 `-ObjC`。

#### CocoaPods 导入
* 在 `Podfile` 添加

```
pod 'XPay'
```

默认会包含 支付宝、微信、银联。你也可以自由组合。  
目前有 `Alipay`、`WxPay`、`UnionPay`、`Bfb` 四个子模块可选择。  
例如：

```
pod 'XPay/Alipay'
pod 'XPay/WxPay'
pod 'XPay/UnionPay'
pod 'XPay/Bfb'
```

* 运行 `pod install`
* 从现在开始使用 `.xcworkspace` 打开项目，而不是 `.xcodeproj`
* 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"。


### 额外配置
* iOS 9 以上版本如果需要使用支付宝和微信渠道，需要在 `Info.plist` 添加以下代码：

```
<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
<string>wechat</string>
<string>alipay</string>
</array>
```

* iOS 9 限制了 http 协议的访问，如果 App 需要访问 `http://`，需要在 `Info.plist` 添加如下代码：

```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

* 如果编译失败，遇到错误信息为：

```
XXXX does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target.
```
请到 Xcode 项目的 Build Settings 标签页搜索 bitcode，将 Enable Bitcode 设置为 NO。


## 注意事项
* 如遇支付宝无法调起正常调起，导入CoreFoundation.framework，并设置为Optional。
* 使用百度钱包时，如遇crash，请检查是否关闭了Xcode的异常断点。

