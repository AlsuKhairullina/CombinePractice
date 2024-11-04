//
//  SwitchesAndButtonViewController.swift
//  TextFieldNumbersRequest
//
//  Created by Алсу Хайруллина on 28.10.2024.
//

import UIKit
import Combine

class SwitchesAndButtonViewController: UIViewController {
    
    //MARK: Published properties
    @Published private var switch1IsOn: Bool = false
    @Published private var switch2IsOn: Bool = false
    
    //MARK: Cancellables
    private var cancellables: AnyCancellable?
    
    //MARK: Views
    private lazy var switch1 = UISwitch()
    private lazy var switch2 = UISwitch()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switch1, switch2, button])
        stack.spacing = 10
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    //MARK: Publisher
    private var validToEnable: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($switch1IsOn, $switch2IsOn)
            .map { one, two in
                one && two
            }.eraseToAnyPublisher()
    }
    
    //MARK: - Objc func
    @objc func switch1Tapped(_ sender: UISwitch) {
        switch1IsOn = sender.isOn
    }
    
    @objc func switch2Tapped(_ sender: UISwitch) {
        switch2IsOn = sender.isOn
    }
    
}

//MARK: - UI Setup
private extension SwitchesAndButtonViewController {
    func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 60),
            vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        switch1.addTarget(self, action: #selector(switch1Tapped), for: .valueChanged)
        switch2.addTarget(self, action: #selector(switch2Tapped), for: .valueChanged)
    }
    
    func setupBindings() {
        cancellables = validToEnable
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: button)
    }
}
