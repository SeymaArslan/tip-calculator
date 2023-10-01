//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by Seyma on 23.09.2023.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₺0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₺0")
                XCTAssertEqual(screen.totalTipValueLabel.label, "₺0")
    }
    
    func testRegularTip() {
        // user enters a $100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        
        // user selects %15
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$115")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$15")
        
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$120")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
        
        // user splits the bill by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$30")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$20")
    }
    
    func textCustomTipAndSplitBillBy2() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalBillValueLabel.label, "$500")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$200")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$250")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()  // resetleme için
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Özel miktar")
    }
}
