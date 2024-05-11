# LottieBridgingTweak

LottieBridgingTweak is a practical example of how to utilize [Lottie](https://github.com/yandevelop/lottie-ios-arm64e) in an Objective-C project via a Swift wrapper. Lottie is a library developed by Airbnb.
Read more about the original Lottie project [here](https://airbnb.io/lottie/#/ios)

## Getting Started
1. Ensure that you have properly installed Lottie from this repository: https://github.com/yandevelop/lottie-ios-arm64e
2. Clone this repository and navigate into the project directory `git clone https://github.com/yandevelop/lottie-bridging-tweak && cd lottie-bridging-tweak`
3. Build: `make package`

## Features
The `LottieWrapper.swift` includes methods to:
- Load and play Lottie animations
- Control animation playback
- Set animation loop mode
- Adjust animation speed
- Change color of animation

 This wrapper serves as a starting point and can be customized to suit your needs. By extending the Swift wrapper, you can access all the features provided by Lottie directly from Objective-C. Please note that while you can modify the code within existing methods, adding new methods requires the (re)compilation of a [swiftmodule header](#swift-interfaces)

The code inside `Tweak.x` hooks into CSCoverSheetViewController (View Controller existent in iOS lockscreen), loads a LottieAnimation from a json file, sets the loop mode and color of the animation.

The Swift wrapper provides an Objective-C compatible interface for using Lottie. It defines a `LottieAnimationView` class with methods for loading and controlling animations. Because Swift enums are incompatible with Objective-C, `LottieLoopMode` is defined in the wrapper class which in turn is exposed to Objective-C via the `LottieWrapper-Swift.h` header file.

## Swift Interfaces
The auto-generated swiftmodule header for the LottieWrapper class is included with Lottie by default. If you want to compile your own wrapper class and header that declares Swift interfaces, please refer to the [Apple Developer Documentation](https://developer.apple.com/documentation/swift/importing-swift-into-objective-c)