# Panya iOS Sample

* [Get Started](#get-started)
	* [Installation](#installation)
		* [Cocoapods](#cocoapods)
	* [Credential](#credential)
	* [Running](#running)
* [Documentation](#documentation)
* [Requirements](#requirements)

## Get Started

### Installation

#### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa 
projects. For usage and installation instructions, visit their website. 

A Podfile has been provided and you can install dependencies by executing
the following command in the root folder:

```sh
pod install
```

Run `pod update` to get the latest `GedditCommerceSDK`.

### Credential

You need to update `ViewController.swift` file and add your app id and secret to be able to access to the features.

*EcommerceExample/EcommerceExample/ViewController.swift:*
```
let sdk = GedditLiveCommerce(appId: "YOUR_APP_ID", appSecret: "YOUR_APP_SECRET", userSettings: userSettings, verbose: true, delegate: self, pipDelegate: self)
```

### Running

1. Open `EcommerceExample.xcworkspace`
2. Build the project `⌘+B`
2. Run the project `⌘+R`

## Documentation

Please visit our [cocoapods repository](https://github.com/gedditlive/GedditSDK/tree/master/GedditCommerceSDK) 
and choose a specific version where a README file will be available.

## Requirements

* iOS 10.0+
* Xcode 12.4+
* Swift 5.0+.
