/*:
 ## Задание 6: Кастомный оператор
 Создайте свой собсвенный оператор для `URLSession.DataTaskPublisher`, который будет проверять `URLResponse`, получаемый из `Output` своего Publisher'а, и в случае чего выбрасывать кастомный тип ошибки с кейсами для разных сценариев
 
 1. Создайте кастомный оператор для `URLSession.DataTaskPublisher`, который работает с `Output` этого Publisher'а
 2. Проверьте, можно ли превратить этот response в экземпляр типа HTTPURLResponse. Если нет, то выкиньте ошибку `HTTPError.nonHTTPRequest`
 3. Проверьте у нового экземпляра типа HTTPURLResponse свойство `statusCode`, что бы оно было в диапазоне 200 до 300 не включительно. В противном случае верните `HTTPError.requestFailed` с полученным статусным кодом
 4. Верните из вашего оператора некоторый Publisher, у которого `Output` будет тип `Data`
 */

import Combine
import Foundation

enum HTTPError: LocalizedError {
    case nonHTTPRequest
    case requestFailed(Int)
    case networkError(URLError)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .nonHTTPRequest:
            return "Recieved non HTTP URL Response"
        case .requestFailed(let statusCode):
            return "Network request failed with statusCode: \(statusCode)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unknown:
            return "Unknown error"
        }
    }
}
