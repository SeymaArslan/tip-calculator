//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Seyma on 26.09.2023.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input { // değerlere göre view controllerdan viewModel e ayarlanacak
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {  // hesaplamalar
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
//        input.billPublisher.sink { bill in
//            print("the bill: \(bill)")
//        }.store(in: &cancellables)
  
//        input.tipPublisher.sink { tip in
//            print("the tip: \(tip)")
//        }.store(in: &cancellables)
//        input.splitPublisher.sink { split in
//            print("the split: \(split)")
//        }.store(in: &cancellables)
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()
        let resetCalculatorPublisher = input.logoViewTapPublisher
        return Output(updateViewPublisher: updateViewPublisher,
                      resetCalculatorPublisher: resetCalculatorPublisher)
    }
    
    
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fiftenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
