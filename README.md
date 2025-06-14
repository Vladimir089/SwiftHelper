
# Swift Helper 🚀

![Swift](https://img.shields.io/badge/Swift-5.7+-orange?style=flat&logo=swift) ![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B-blue) ![License](https://img.shields.io/badge/License-MIT-lightgrey)

  

****SwiftHelper**** — универсальная библиотека для iOS, которая не только упрощает работу с платежными SDK, но и предоставляет готовые UI-компоненты. Это комплексное решение для управления подписками, покупками и отображением paywall в ваших приложениях.

  

## Ключевые возможности 🔑

  

### 💳 Управление платежами

- 🧮 Упрощенное получение очищенных цен и валют
- 📅 Упрощённая работа с периодами подписок
- 🆓 Обнаружение и управление пробными периодами
- 🛒 Упрощенная покупка подписок и расходуемых продуктов
- 🔄 Упрощенное восстановление покупок 
- ✅ Проверка статуса Premium-подписки 
- 🧩 Модульная архитектура для будущего расширения

  

### 🎨 Готовые UI-компоненты (скоро!)

- Кастомные paywall-экраны
- Кнопки покупки с автоматическим оформлением
- Дисплеи статуса подписки
- Адаптивные элементы для разных устройств

  

## Текущая поддержка ✅

  

### Apphud SDK

- [x] Получение цен и валют

- [x] Управление периодами подписок

- [x] Работа с пробными периодами

- [x] Покупка подписок и продуктов

- [x] Восстановление покупок

- [x] Проверка статуса Premium-подписки

- [ ] UI компоненты для paywall

  

### Скоро в релизах 🚧

- [ ] Готовые UI-компоненты

  

## Установка 📦

  

Добавьте SwiftHelper в ваш проект через Swift Package Manager (SPM):

  

### Через Xcode

1. Откройте ваш проект в Xcode

2. Перейдите в `File > Add Packages...`

3. Вставьте URL репозитория:

`https://github.com/Vladimir089/SwiftHelper.git`

4. Нажмите "Add Package"

  

  

  

### Через Package.swift

Добавьте зависимость в ваш `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/Vladimir089/SwiftHelper.git",
        from: "0.1.0"
            )
]

```

  

  

## Начало работы 🏁

  

### Работа с  Apphud 💸


 - #### Инициализация Apphud SDK
 В `AppDelegate.swift` или `SceneDelegate.swift` добавьте:
 ```swift
import SwiftHelper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Инициализируйте Apphud SDK
    Apphud.start(apiKey: "YOUR_APPHUD_KEY")
    return true
    }
}
```

 - #### Получение цены и символа валюты

```swift
import  SwiftHelper

SwiftHelper.apphudHelper.returnClearPriceAndSymbol(product: ApphudProduct) -> (price: Double, symbol: String)
```

 - #### Получение длительности подписки

```swift
import  SwiftHelper

SwiftHelper.apphudHelper.returnSubscriptionUnit(product: ApphudProduct) -> String? (week, month, year)
```

 - #### Получение продолжительности подписки

```swift
import  SwiftHelper

SwiftHelper.apphudHelper.returnSubscriptionDuration(product: ApphudProduct) -> Int?
```

 - #### Проверка пробного периода у продукта

```swift
import  SwiftHelper

SwiftHelper.apphudHelper.hasIntroductoryTrial(product: ApphudProduct) -> Bool
```

 - #### Получение цены и символа пробного периода


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.returnIntroductoryPriceAndSymbol(product: ApphudProduct) -> (price: Double, symbol: String)
```

 - #### Получение длительности пробного периода


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.returnIntroductoryTrialDuration(product: ApphudProduct) -> (value: Int, unit: String)? 
```

 - #### Получение списка продуктов из paywall по id


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.fetchProducts(paywallID: String, completion: @escaping ([ApphudProduct]) -> Void)
```

 - #### Проверка наличия активной подписки у пользователя


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.isProUser() -> Bool
```

 - #### Восстановление всех покупок


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.restoreAllProducts(completion: @escaping (Bool) -> Void)
```

 - #### Приобретение подписки


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.purchaseSubscription(subscription: ApphudProduct, completion: @escaping (Bool) -> Void)
```

- #### Приобретение расходуемого продукта


```swift
import  SwiftHelper

SwiftHelper.apphudHelper.purchaseConsumableProduct(product: ApphudProduct, completion: @escaping (Bool) -> Void)
```

### Работа с  UI 💸
#### В разработке 

## Вклад в проект 🤝

#### Приветствуются pull requests! Перед внесением изменений:

- Создайте issue для обсуждения
- Сделайте форк репозитория
- Создайте новую ветку (`feature/your-feature`)
- Отправьте pull request


<p align="center"> ✨ Сделано с любовью к Swift-сообществу ✨<br> 
