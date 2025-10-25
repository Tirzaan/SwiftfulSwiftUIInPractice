//
//  SwiftfulSwiftUIInPracticeApp.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import SwiftUI
import SwiftfulRouting
import UIKit
import ObjectiveC.runtime

@main
struct SwiftfulSwiftUIInPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                AllAppsView()
            }
            .onAppear {
                _ = _installNavPopGestureConfig
            }
        }
    }
}
// Trigger installation at module load time

private final class _NavPopGestureDelegateProxy: NSObject, UIGestureRecognizerDelegate {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let nav = navigationController else { return false }
        return nav.viewControllers.count > 1
    }
}

private var _navDelegateKey: UInt8 = 0

private extension UINavigationController {
    var _popGestureDelegateProxy: _NavPopGestureDelegateProxy {
        if let existing = objc_getAssociatedObject(self, &_navDelegateKey) as? _NavPopGestureDelegateProxy {
            return existing
        }
        let proxy = _NavPopGestureDelegateProxy(navigationController: self)
        objc_setAssociatedObject(self, &_navDelegateKey, proxy, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return proxy
    }

    // Ensure the interactivePopGestureRecognizer's delegate is configured once
    func _configureInteractivePopGestureDelegateIfNeeded() {
        // Only set our proxy if the recognizer exists
        if let recognizer = self.interactivePopGestureRecognizer {
            // Assign our proxy as the delegate
            recognizer.delegate = _popGestureDelegateProxy
        }
    }

    // Swizzle viewDidLoad once to inject our configuration without declaring protocol conformance
    static func _installPopGestureConfigurationOnce() {
        struct _Once { static var didInstall = false }
        guard !_Once.didInstall else { return }
        _Once.didInstall = true

        let originalSelector = #selector(UIViewController.viewDidLoad)
        let swizzledSelector = #selector(UIViewController._swizzled_viewDidLoad_forNavPopGesture)

        guard
            let originalMethod = class_getInstanceMethod(UINavigationController.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UINavigationController.self, swizzledSelector)
        else { return }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

private extension UIViewController {
    @objc func _swizzled_viewDidLoad_forNavPopGesture() {
        // Call original implementation (which is now swizzled)
        _swizzled_viewDidLoad_forNavPopGesture()

        // If self is a UINavigationController, configure its gesture delegate
        if let nav = self as? UINavigationController {
            nav._configureInteractivePopGestureDelegateIfNeeded()
        }
    }
}

// Install the configuration when the app starts up
private let _installNavPopGestureConfig: Void = {
    UINavigationController._installPopGestureConfigurationOnce()
}()
