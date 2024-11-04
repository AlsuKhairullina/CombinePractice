/*:
 ## Задание 1: Простая последовательность событий
 
 Создайте последовательность чисел от 1 до 10 и используйте Combine для выполнения следующих шагов:
 1. Отфильтруйте только четные числа
 2. Умножьте каждое число на 3
 3. Выведите результат в консоль
 */

import Combine

let numbers = (1...10).publisher

let cancellable = numbers
    .filter { $0 % 2 == 0 }
    .map { $0 * 3 }
    .collect()
    .sink { values in
        let result = values.map { "\($0)" }.joined(separator: ", ")
        print(result)
    }


