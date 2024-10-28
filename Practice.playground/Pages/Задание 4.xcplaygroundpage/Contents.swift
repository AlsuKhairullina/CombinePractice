/*:
 ## Задание 4: Создание единой подписки
 С помощью Combine создайте для заданых subject единую подписку со значением типа `Int` в блоке `sink`
*/

import Combine

let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<String, Never>()

let subscription1 = subject1
    .sink { num in
        print(num)
    }

let subscription2 = subject2
    .sink { str in
        print(str)
    }
