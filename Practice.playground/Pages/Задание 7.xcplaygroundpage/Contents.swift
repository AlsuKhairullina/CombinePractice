/*:
 ## Задание 7: Предотвращение завершения Publisher'а после получения ошибки
 Предотвратите ситуацию, которая приводит к завершению работы вышестоящего Publisher'а при получении ошибки у нижестоящего Publisher'а в блоке `flatMap`, сохранив этот оператор в pipeline вышестоящего Publisher'а.
 Добейтесь такого поведения, что бы после получения значений (3, 0), жизненный цикл вышестоящего Publisher'а не обрывался, и были обработаны результаты следующих посылаемых значений
*/

import Foundation
import Combine

struct DivideByZeroError: Error { }

func div(lhs: Double, rhs: Double) -> AnyPublisher<Double, DivideByZeroError> {
    guard rhs != 0 else {
        return Fail(error: DivideByZeroError())
            .eraseToAnyPublisher()
    }
    
    return Just(lhs / rhs)
        .setFailureType(to: DivideByZeroError.self)
        .eraseToAnyPublisher()
}

let numbersSubject = PassthroughSubject<(Double, Double), Never>()

let subscription = numbersSubject
    .flatMap { lhs, rhs in
        div(lhs: lhs, rhs: rhs)
    }
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print("Result: \(value)")
    }

numbersSubject.send((10, 5))

numbersSubject.send((2, 2))

numbersSubject.send((3, 0)) //Error

numbersSubject.send((12, 2))

numbersSubject.send((20, 4))

