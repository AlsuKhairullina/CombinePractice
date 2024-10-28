/*:
 ## Задание 5: Загрузка данных из сети
 Используйте Combine для загрузки данных из сети и их обработки:

 1. Используйте URLSession для загрузки списка постов. Для этого используйте данный URL: [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts).
 2. Преобразуйте полученные данные в массив объектов модели данных.
 3. Выведите заголовки постов в консоль.
*/

import Foundation
import Combine

///Модель для парсинга JSON
struct Post: Decodable {
    let title: String
    let body: String
}
