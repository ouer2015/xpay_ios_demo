# xpay_ios_demo
旋涡科技支付组件 
=================

****

## 版本要求

iOS SDK 要求 iOS 7.0 及以上版本

## 接入方法
### 安装
#### 使用 CocoaPods
1. 在 `Podfile` 添加

```
pod 'XPay', '~> 1.1.02'
```

默认会包含 支付宝、微信、银联。你也可以自己选择渠道。  
目前有 `Alipay`、`WxPay`、`UnionPay`、`Bfb` 五个子模块可选择。  
例如：

```
pod 'XPay/Alipay', '~> 1.1.02'
pod 'XPay/WxPay', '~> 1.1.02'
pod 'XPay/UnionPay', '~> 1.1.02'
pod 'XPay/Bfb', '~> 1.1.02'
```

2. 运行 `pod install`
3. 从现在开始使用 `.xcworkspace` 打开项目，而不是 `.xcodeproj`
4. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"。

#### 手动导入
1. 获取 SDK  
下载 SDK, 里面包含了 example 文件夹。example 文件夹里面是 SDK 的文件，以及一个示例demo。
2. 依赖 Frameworks：

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

百度钱包所需：

```
libstdc++.tbd
AddressBook.framework
AddressBookUI.framework
AudioToolbox.framework
CoreAudio.framework
CoreGraphics.framework
MapKit.framework
MessageUI.framework
QuartzCore.framework
```

3. 如果不需要某些渠道，删除 `sdk/Channel` 下的相应目录即可。
4. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"。
5. 添加 Other Linker Flags：在 Build Settings 搜索 Other Linker Flags ，添加 `-ObjC`。

### 额外配置
1. iOS 9 以上版本如果需要使用支付宝和微信渠道，需要在 `Info.plist` 添加以下代码：

```
<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
<string>wechat</string>
<string>alipay</string>
</array>
```
2. iOS 9 限制了 http 协议的访问，如果 App 需要访问 `http://`，需要在 `Info.plist` 添加如下代码：

```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
3. 如果编译失败，遇到错误信息为：

```
XXXXXXX does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target.
```
请到 Xcode 项目的 Build Settings 标签页搜索 bitcode，将 Enable Bitcode 设置为 NO。


## 注意事项
1.如遇支付宝无法调起正常调起，导入CoreFoundation.framework，并设置为Optional。
2.使用百度钱包时，如遇crash，请检查是否关闭了Xcode的异常断点。

