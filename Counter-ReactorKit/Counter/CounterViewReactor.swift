//
//  CounterViewReactor.swift
//  Counter-ReactorKit
//
//  Created by 민도현 on 2022/12/05.
//

import Foundation
import RxCocoa
import RxSwift
import ReactorKit

class CounterViewReactor: Reactor {
    let initialState = State()
    
    //사용자의 입력 및 상호작용
    enum Action {
        case increase
        case decrease
    }
    
    //Action 과 State 의 다리 역할
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    // 뷰의 상태
    struct State {
        var value = 0
        var isLoading = false
    }
    
    //Action 을 바탕으로 Observable 생성, 비동기 연산이나 API 호출
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    //Mutation을 바탕으로 새로운 State 생성
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
