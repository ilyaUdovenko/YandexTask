# YandexTask
YandexTest

Задача 1: контейнерный контроллер без использования autolayout 

Существует класс BeautifulCardViewController: UIViewController. 

Его view отвечает на метод sizeThatFits, возвращая минимальный размер, в котором его необходимо расположить для корректного отображения. 

Необходимо реализовать свой UIViewController, который отвечает следующим условиям: 

1. принимает BeautifulCardViewController в качестве зависимости; 

2. размещает его view по центру своего view в размере, достаточном для корректного его отображения; 

3. BeautifulCardViewController.view занимает как можно меньше места на экране. 

При реализации нельзя использовать autolayout.
Задача 2: конкурентный доступ к мутабельным данным 

Задан источник данных:
enum DataSource {
 static func aqcuireNextItem(currentItem: String, completion: @escaping (String) -> Void) {
  queue.async {
    let result = ... // some async job to receive result
    completion(result)
  }
 }

 private static let queue: DispatchQueue
}
Источник полностью потокобезопасен, не использует главную очередь, асинхронно получает данные и возвращает результат в completion на внутренней приватной очереди. 

Есть класс, выступающий фасадом для последних полученных данных, которые обновляются раз в секунду. Сервисы читают из него данные на главном потоке:
final class Producer {
 var currentItem: String

 init() {
   currentItem = ""
   scheduleNextRequest()
 }

 private func scheduleNextRequest() {
     DispatchQueue.main.asyncAfter(timeout: .now() + .seconds(1), execute: onDataRequested)
 }

 private func onDataRequested() {
   DataSource.acquireNextItem(currentItem: currentItem) { result in 
     DispatchQueue.main.async {
       self.currentItem = currentItem
     }
     scheduleNextRequest()
   }
 }
}
В какой-то момент потребителей currentItem стало очень много и все они оказались на разных очередях. В результате главный поток оказался забит операциями чтения currentItem и интерфейс стал тормозить. 

Необходимо модифицировать класс Producer таким образом, чтобы он: 

1. максимально эффективно работал в случае, когда запросов на чтение currentItem очень много и они все исходят с разных очередей; 

2. не использовал DispatchQueue.main.
Задача 3: группировка асинхронно получаемых данных 

Есть функция: 

func run(command: String, response: @escaping (String) -> Void, responseQueue: DispatchQueue) 

Функция полностью потокобезопасна, выполняет команду и выдает результат в блоке response, который выполняется на очереди responseQueue. 

Необходимо написать фукнцию: 

func run(commands: [String], response: @escaping ([String]) -> Void, responseQueue: DispatchQueue) 

удовлетворяющую следующим требованиям: 

1. порядок передаваемых в response результатов соответствует порядку передаваемых в commands команд; 

2. команды выполняются параллельно; 

3. responseQueue используется только для вызова reponse при передаче результата.
