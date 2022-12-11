//
//  Counter_ReactorKitTests.swift
//  Counter-ReactorKitTests
//
//  Created by 민도현 on 2022/12/05.
//

import XCTest
@testable import Counter_ReactorKit

final class Counter_ReactorKitTests: XCTestCase {
//    let sut = CounterViewController()
    
//    func testAction_whenDidTapIncreaseButtonDidTap_thenMutationIsIncreaseInReactor() {
//        let counterReactor = CounterViewReactor()
//        counterReactor.isStubEnabled = true
//
//        let counterViewController = sut
////        counterViewController.loadViewIfNeeded()
//        counterViewController.reactor = counterReactor
//
//        counterViewController.increaseButton.sendActions(for: .touchUpInside)
//
//        XCTAssertEqual(counterReactor.stub.actions.last, .increase)
//    }
//
//    func testAction_whenDidTapDecreaseButtonInView_thenMutationIsDecreaseInReactor() {
//        // Given
//        let counterReactor = CounterViewReactor()
//        counterReactor.isStubEnabled = true
//
//        let counterViewController = sut
////        counterViewController.loadViewIfNeeded() // IBOutlet과 Action을 구성하기 위해서 호출
//        counterViewController.reactor = counterReactor
//
//        // When
//        counterViewController.decreaseButton.sendActions(for: .touchUpInside)
//
//        // Then
//        XCTAssertEqual(counterReactor.stub.actions.last, .decrease)
//    }
    
    func testReactor_whenExcuteIncreaseButtonTapActionInView_thenStateIsLoadingInReactor() {
        // Given
        let reactor = CounterViewReactor()
        
        // When
        reactor.isStubEnabled = true
        reactor.action.onNext(.increase)
        
        // Then
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
