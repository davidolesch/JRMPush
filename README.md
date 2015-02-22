# JRMPush

[![Version](https://img.shields.io/cocoapods/v/JRMPush.svg?style=flat)](http://cocoadocs.org/docsets/JRMPush)
[![License](https://img.shields.io/cocoapods/l/JRMPush.svg?style=flat)](http://cocoadocs.org/docsets/JRMPush)
[![Platform](https://img.shields.io/cocoapods/p/JRMPush.svg?style=flat)](http://cocoadocs.org/docsets/JRMPush)

![](https://raw.githubusercontent.com/davidolesch/JRMPush/master/ClassAnnouncement.gif)

## Usage

Install this library through [CocoaPods](http://cocoapods.org) and then replace your app code which handles the push notification userInfo dictionary with 

```obj-c
[[JRMPushHandler sharedInstance] handlePush:userInfo].
```

JRMPushHandler is documented [here](http://cocoadocs.org/docsets/JRMPush/0.1.0/Classes/JRMPushHandler.html).

## Requirements

requires 'SVWebViewController', '~> 1.0'

## Installation

JRMPush is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "JRMPush"

## Author

David Olesch, david@jackrabbitmobile.com

## License

JRMPush is available under the MIT license. See the LICENSE file for more info.

