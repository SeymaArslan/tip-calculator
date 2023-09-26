//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Seyma on 26.09.2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
