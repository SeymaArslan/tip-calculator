//
//  tip_calculatorSnapshotTest.swift
//  tip-calculatorTests
//
//  Created by Seyma on 28.09.2023.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshotTest: XCTestCase{
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width  // ekran width i aldık
    }
    
    func testLogoView() {
        let size = CGSize(width: screenWidth, height: 48) // GIVEN -- 48 deme sebebimiz viewController da tanımladığımız değerin de 48 olması
        let view = LogoView() // WHEN
        
        //        assertSnapshot(matching: view, as: .image(size: size), record: true)  // ekran kaydı için ve daha sonra kapatarak devam ediyoruz
        assertSnapshot(matching: view, as: .image(size: size)) // THEN
    }
    
    func testInitialResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        let size = CGSize(width: screenWidth, height: 224)
        let result = Result(amountPerPerson: 100.25, totalBill: 45, totalTip: 60)
        let view = ResultView()
        view.configure(result: result)
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }

    func testTipInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last  // .first ken split değeri 1, last iken 2 geldi
        button?.sendActions(for: .touchUpInside)
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
}

// buradaki fonksiyonun yaptığı şey, viewımızın tüm görünümleri ve bu görünümün ne olduğunu belirtebiliriz çünkü bu genel bir fonksiyondur.
extension UIView {  // stackoverflow.com/a/45297466/6181721
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
