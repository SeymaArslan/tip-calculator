//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Seyma on 29.09.2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {  // burada local bir view yaratacağız. sebebi ise bu local view a dokunduğumuz (logo çift tıklama) bir task yapmak istememiz.. formun resetlendiğini test edeceğiz.
        case logoView
    }
    
    enum ResultVİew: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String { // burada textField içine değerleri girmekle ilgileniyoruz
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
    
}
