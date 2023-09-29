//
//  CalculatorScreen.swift
//  tip-calculator
//
//  Created by Seyma on 29.09.2023.
//

import XCTest

class CalculatorScreen {
    private let app: XCUIApplication
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement { // XCUIElement tüm farklı öğeleri temsil eder
        return app.staticTexts[ScreenIdentifier.ResultVİew.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultVİew.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultVİew.totalTipValueLabel.rawValue]
    }
    
}
