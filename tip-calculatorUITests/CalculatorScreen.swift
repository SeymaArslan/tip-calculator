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
    
    // Logo View
    var logoView: XCUIElement {
        app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    
    //MARK: - Result View
    var totalAmountPerPersonValueLabel: XCUIElement { // XCUIElement tüm farklı öğeleri temsil eder
        app.staticTexts[ScreenIdentifier.ResultVİew.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultVİew.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultVİew.totalTipValueLabel.rawValue]
    }
    
    
    // Bill Input View
    var billInputViewTextField: XCUIElement {
        app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // Tip input view
    var tenPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    var fifteenPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    var twentyPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    var customTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    var customTipAlertTextField: XCUIElement {
        app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    // split input view
    var incerementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    var decrementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    var splitValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // Actions
    func enterBill(amount: Double) {
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n")  // \n ifadesi keybourd u kapatır
    }
    
    func selectTip(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fifteenPercentTipButton.tap()
        case .twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incerementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
}
