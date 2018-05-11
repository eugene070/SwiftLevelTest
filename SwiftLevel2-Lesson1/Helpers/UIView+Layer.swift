//
//  UIView+Layer.swift
//  SwiftLevel2-Lesson1
//
//  Created by Eugene Losev on 10.05.2018.
//  Copyright © 2018 Eugene Losev. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
