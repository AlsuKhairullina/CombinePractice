//
//  TextFieldsViewController.swift
//  TextFieldNumbersRequest
//
//  Created by Алсу Хайруллина on 28.10.2024.
//

import UIKit
import Combine

class TextFieldsViewController: UIViewController {

    //MARK: Views
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var multiplyButton: UIButton!
    
    //MARK: Properties
    private let inputTextSubject = CurrentValueSubject<String?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupBindings()
    }

    //MARK: - Actions
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        guard let text = inputTextField.text, let number = Int(text) else { return }
        
        asyncMultiplyByTwo(number: number)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.resultLabel.text = "\(result)"
            }
            .store(in: &cancellables)
    }
}

//MARK: - Private Methods
private extension TextFieldsViewController {
    
    ///Добавляет action для отслеживания ввода текста
    func setupTextField() {
        inputTextField.addAction(
            UIAction { [weak self] _ in
                let text = self?.inputTextField.text
                self?.inputTextSubject.send(text)
            },
            for: .editingChanged
        )
    }
    
    func setupBindings() {
        inputTextSubject
            .sink { [weak self] text in
                guard let self = self else { return }
                
                if let text = text, Int(text) != nil {
                    self.setTextFieldBorderColor(.clear)
                    self.multiplyButton.isEnabled = true
                } else {
                    self.setTextFieldBorderColor(.red)
                    self.multiplyButton.isEnabled = false
                }
            }
            .store(in: &cancellables)
    }
    
    func setTextFieldBorderColor(_ color: UIColor) {
        inputTextField.layer.borderColor = color.cgColor
        inputTextField.layer.borderWidth = color == .clear ? 0 : 0.5
        inputTextField.layer.cornerRadius = 5
    }
    
    //Асинхронно выполняет умножение переданного числа на 2 со случайной задержкой до 3 секунд
    func asyncMultiplyByTwo(number: Int) -> AnyPublisher<Int, Never> {
        Deferred {
            Future { promise in
                DispatchQueue.global().asyncAfter(deadline: .now() + .random(in: 1...3)) {
                    promise(.success(number * 2))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

