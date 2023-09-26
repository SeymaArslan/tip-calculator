//
//  String+Extension.swift
//  tip-calculator
//
//  Created by Seyma on 26.09.2023.
//

import Foundation

extension String {
    var doubleValue: Double? {
        Double(self)  // if this string value can be cast into a double, then you'll get a value. Otherwise, it will be your return and name
    }
}
