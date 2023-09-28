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
    
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {  // class olan değil bu setup.. Bir test her çağrıldığında setUp metodu çağırılır ve sut un bir örneğini oluşturur
//        sut = .init() // init audioPlayerService içeriyor. Bu oluşturduğumuz protocol ve hiçbir şey aktarmamıza gerek yok çünkü şu an ses oynatıcısını test etmiyoruz
        audioPlayerService = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {  // yine class olan değil.. Test sona erdiğinde veya tamamlandığında, sut u resetleyen tearDown metodunu çağırır.
        sut = nil // nil yaptık böylelikle her test CalculatorVM sinin yenilenen yeni bir isteğini(örnek) alacağız
        cancellables = nil
        audioPlayerService = nil
        logoViewTapSubject = nil
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
    
    func testResultWithoutTipFor2Person() {  // test butonu gelmezse final class alanından itibaren test ediyoruz
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        let bill: Double = 200.0
        let tip: Tip = .custom(value: 201)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100.25)
            XCTAssertEqual(result.totalBill, 401)
            XCTAssertEqual(result.totalTip, 201)
        }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
        // GİVEN
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        //THEN
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        //WHEN
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
    
}

class MockAudioPlayerService: AudioPlayerService {
    var expectation = XCTestExpectation(description: "playSound is called")
    func playSound() {
        expectation.fulfill()
    }
}
