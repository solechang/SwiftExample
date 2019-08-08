//
//  UINavigationController+Extension.swift
//  PhunChallenge
//
//  Created by Chang Choi on 8/4/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import Foundation
import UIKit
// To enable upsideDown portrait. iPhone X+ are not suppported for upside Down portrait mode as per Apple's Design: via https://forums.developer.apple.com/thread/87165
extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
    
}
