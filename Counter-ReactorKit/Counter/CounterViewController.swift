//
//  ViewController.swift
//  Counter-ReactorKit
//
//  Created by 민도현 on 2022/12/05.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit
import SnapKit
import Then

class CounterViewController: UIViewController, View {
    
    internal var disposeBag = DisposeBag()
    
    private let counterLabel = UILabel().then {
        $0.text = "0"
    }
    
    let increaseButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let decreaseButton = UIButton().then {
        $0.setTitle("-", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    lazy var activityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addView()
        setLayout()
    }
    
    //ReactorKit 내부적으로 호출
    func bind(reactor: CounterViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: CounterViewReactor) {
        increaseButton.rx.tap
            .map { CounterViewReactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { CounterViewReactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: CounterViewReactor) {
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    private func addView() {
        [counterLabel, decreaseButton, increaseButton, activityIndicatorView].forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        counterLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        decreaseButton.snp.makeConstraints {
            $0.trailing.equalTo(counterLabel.snp.leading).offset(-40)
            $0.centerY.equalToSuperview()
        }
        
        increaseButton.snp.makeConstraints {
            $0.leading.equalTo(counterLabel.snp.trailing).offset(40)
            $0.centerY.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints {
            $0.top.equalTo(counterLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}
