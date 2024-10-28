import UIKit
import Combine

class ViewController: UIViewController {

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
    }

    //MARK: - Actions
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        
    }
}

//MARK: - Private Methods
private extension ViewController {
    
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
