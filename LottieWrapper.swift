//
//  LottieWrapper.swift
//  lottie-bridging-example
//
//  Created by jan on 03.04.24.
//

import Foundation
import Lottie
import UIKit

@objc enum LottieLoopMode: Int {
    case playOnce
    case loop
    case autoReverse
    case `repeat`
    case repeatBackwards
}

@objc(LottieAnimationView) class objc_wrapper_AnimationView: UIView {
    private let animationView: LottieAnimationView
    
    @objc override init(frame: CGRect) {
        animationView = LottieAnimationView()

        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        animationView = LottieAnimationView()

        super.init(coder: aDecoder)
        commonInit()
    }
    
    @objc func loadAnimation(path animationPath: String) {
        if let animation = LottieAnimation.filepath(animationPath, animationCache: DefaultAnimationCache.sharedCache) {
        animationView.animation = animation
        } else {
            assertionFailure("Could not load animation from path: \(animationPath)")
        }
    }
    
    @objc func loadAnimation(name animationName:String) {
        if let path = Bundle.main.path(forResource: animationName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let animation:LottieAnimation = try JSONDecoder().decode(LottieAnimation.self, from: data)
                animationView.animation = animation
                animationView.backgroundBehavior = .pauseAndRestore
            } catch {
                assertionFailure("Could not read Lottie json file")
            }
        }
    }
    
    @objc func play(completion: LottieCompletionBlock? = nil) {
        animationView.play(completion: completion)
    }

    @objc func play() {
        animationView.play()
    }

    public func pause() {
        animationView.pause()
    }

    @objc func stop() {
        animationView.stop()
    }

    @objc func setLoopMode(_ loopMode: LottieLoopMode) {
        switch loopMode {
        case .playOnce:
            animationView.loopMode = .playOnce
        case .loop:
            animationView.loopMode = .loop
        case .autoReverse:
            animationView.loopMode = .autoReverse
        case .repeat:
            animationView.loopMode = .repeat(1)
        case .repeatBackwards:
            animationView.loopMode = .repeatBackwards(1)
        }
    }

    @objc func setLoopMode(_ loopMode: LottieLoopMode, count: Float) {
        switch loopMode {
            case .playOnce: break
            case .loop: break
            case .autoReverse: break
            case .repeat:
                animationView.loopMode = .repeat(count)
            case .repeatBackwards:
                animationView.loopMode = .repeatBackwards(count)
        }
    }
    
    @objc func loop() {
        animationView.loopMode = .loop
    }
    
    @objc func allHierarchyKeypaths() -> NSArray {
        let keypaths = animationView.allHierarchyKeypaths()
        return NSArray(array: keypaths)
    }
    
    @objc func logHierarchyKeypaths() {
        NSLog("%@", animationView.allHierarchyKeypaths())
    }

    // MARK: - Animation Properties
    @objc func colorAnimation(_ colorName: UIColor, keypath: String) {
        let provider = ColorValueProvider(colorName.lottieColorValue)
        
        let keypath = AnimationKeypath(keypath: keypath)
        
        animationView.setValueProvider(provider, keypath: keypath)
    }

    @objc func setAnimationSpeed(_ speed: CGFloat) {
        animationView.animationSpeed = speed
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }

    private func setUpViews() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)
        animationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
