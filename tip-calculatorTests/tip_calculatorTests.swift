//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Seyma on 23.09.2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {

    //MARK: - sut -> System Under Test

    private var sut: CalculatorVM! // sut, sistem ve test anlamına gelir. Peki temel olarak test ettiğimiz nesne nedir? Bu uygulama MVVM mimarisinde oluşturuldu ve bu nedenle tüm iş beyin dediğimiz VM'in içerisinde gerçekleşti VM içindeki mantık ve bu nedenle öncelikle hesap makinesi için Test edeceğiz
    private var cancellables: Set<AnyCancellable>!
    
    private let logoViewTapSubject = PassthroughSubject<Void, Never>()
    
    override func setUp() {  // class olan değil bu setup.. Bir test her çağrıldığında setUp metodu çağırılır ve sut un bir örneğini oluşturur
        sut = .init() // init audioPlayerService içeriyor. Bu oluşturduğumuz protocol ve hiçbir şey aktarmamıza gerek yok çünkü şu an ses oynatıcısını test etmiyoruz
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {  // yine class olan değil.. Test sona erdiğinde veya tamamlandığında, sut u resetleyen tearDown metodunu çağırır.
        sut = nil // nil yaptık böylelikle her test CalculatorVM sinin yenilenen yeni bir isteğini(örnek) alacağız
        cancellables = nil
        super.tearDown()
    }
    
    func testResultWithoutTipFor1Person() {
        let bill: Double = 100.0 // GIVEN
        let tip: Tip = .none  // GIVEN
        let split: Int = 1 // GIVEN
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input) // WHEN
        
        output.updateViewPublisher.sink { result in  // THEN -> çıktının doğru olduğunu test etmek istediğimiz alan
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
    
}
