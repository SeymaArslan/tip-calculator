//
//  ResultView.swift
//  tip-calculator
//
//  Created by Seyma on 23.09.2023.
//

import UIKit

class ResultView: UIView {
    init() {
        super.init(frame: .zero)  // Otomatik düzeni kaldırmak için zero kullandık
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .gray
    }
    
}
