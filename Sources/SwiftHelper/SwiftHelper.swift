//
//  Apphud.swift
//  UniversalSwiftHelper
//
//  Created by Владимир on 13.06.2025.
//

import Foundation
import ApphudSDK


public final class SwiftHelper {
    ///ApphudHelper для работы с Apphud SDK.
    @MainActor public static let apphudHelper = ApphudHelper()
}


/// Класс-обёртка над ApphudSDK с удобными методами.
public class ApphudHelper {
    
    // MARK: - Price
    
    /// Получает очищенную цену и символ валюты из `ApphudProduct`.
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: Кортеж с округлённой ценой (`price`) и символом валюты (`symbol`).
    public func returnClearPriceAndSymbol(product: ApphudProduct) -> (price: Double, symbol: String) {
        let price = product.skProduct?.price.doubleValue ?? 0.0
        let roundedPrice = Double(round(100 * price) / 100)
        let symbol = product.skProduct?.priceLocale.currencySymbol ?? ""
        return (roundedPrice, symbol)
    }

    // MARK: - Subscription Duration
    
    /// Получает единицу измерения периода подписки (`week`, `month`, `year`).
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: Строка с единицей времени, либо `nil`, если период не определён.
    public func returnSubscriptionUnit(product: ApphudProduct) -> String? {
        guard let unit = product.skProduct?.subscriptionPeriod?.unit else {
            print("Subscription period unit is not available for this product.")
            return nil
        }
        
        switch unit {
        case .day:
            return "week" //bug
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        @unknown default:
            return nil
        }
    }

    /// Получает продолжительность подписки в выбранных единицах времени.
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: Количество единиц времени (например, 1 месяц, 3 месяца и т.д.), либо `nil`.
    public func returnSubscriptionDuration(product: ApphudProduct) -> Int? {
        return product.skProduct?.subscriptionPeriod?.numberOfUnits
    }

    // MARK: - Intro Price
    
    /// Проверяет наличие пробного периода (Introductory Offer) у продукта.
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: `true`, если есть пробный период; иначе `false`.
    public func hasIntroductoryTrial(product: ApphudProduct) -> Bool {
        return product.skProduct?.introductoryPrice != nil
    }

    /// Получает цену и символ валюты пробного периода (если он есть).
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: Кортеж с округлённой ценой и символом валюты. Если цена отсутствует, вернёт `(0.0, "")`.
    public  func returnIntroductoryPriceAndSymbol(product: ApphudProduct) -> (price: Double, symbol: String) {
        guard let introPrice = product.skProduct?.introductoryPrice else {
            print("No introductory price available for this product.")
            return (0.0, "")
        }
        
        let price = introPrice.price.doubleValue
        let roundedPrice = Double(round(100 * price) / 100)
        let symbol = product.skProduct?.priceLocale.currencySymbol ?? ""
        
        return (roundedPrice, symbol)
    }
    
    /// Получает продолжительность пробного периода (Introductory Offer), если он доступен.
    /// - Parameter product: Продукт типа `ApphudProduct`.
    /// - Returns: Кортеж с количеством единиц (`value`) и единицей измерения (`unit`), например: (3, "day"). Вернёт `nil`, если пробный период отсутствует.
    public func returnIntroductoryTrialDuration(product: ApphudProduct) -> (value: Int, unit: String)? {
        guard let trialPeriod = product.skProduct?.introductoryPrice?.subscriptionPeriod else {
            return nil
        }

        let value = trialPeriod.numberOfUnits
        let unit: String

        switch trialPeriod.unit {
        case .day: unit = "day"
        case .week: unit = "week"
        case .month: unit = "month"
        case .year: unit = "year"
        @unknown default: return nil
        }

        return (value, unit)
    }


    // MARK: - Products
    
    /// Получает список продуктов из paywall'а по его идентификатору.
    /// - Parameters:
    ///   - paywallID: Идентификатор paywall'а.
    ///   - completion: Замыкание с массивом продуктов `ApphudProduct`.
    @MainActor
    public func fetchProducts(paywallID: String, completion: @escaping ([ApphudProduct]) -> Void) {
        Apphud.paywallsDidLoadCallback { paywalls, _ in
            guard let paywall = paywalls.first(where: { $0.identifier == paywallID }) else {
                print("Paywall not found for ID: \(paywallID)")
                completion([])
                return
            }
            completion(paywall.products)
        }
    }

    /// Проверяет наличие активной подписки (Pro).
    /// - Returns: `true`, если у пользователя есть доступ к premium-функциям.
    public func isProUser() -> Bool {
        return Apphud.hasPremiumAccess()
    }

    /// Восстанавливает все покупки пользователя.
    /// - Parameter completion: Замыкание, возвращающее `true`, если хотя бы одна подписка активна.
    @MainActor
    public func restoreAllProducts(completion: @escaping (Bool) -> Void) {
        Apphud.restorePurchases { subscriptions, _, error in
            if let error = error {
                print("Failed to restore purchases: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let subscription = subscriptions?.first, subscription.isActive() {
                completion(true)
                return
            }

            if Apphud.hasActiveSubscription() {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    // MARK: - Purchase
    
    /// Покупает подписку ApphudProduct.
    /// - Parameters:
    ///   - subscription: Продукт подписки.
    ///   - completion: Замыкание, возвращающее `true`, если подписка активна.
    @MainActor
    public func purchaseSubscription(subscription: ApphudProduct, completion: @escaping (Bool) -> Void) {
        Apphud.purchase(subscription) { result in
            if let error = result.error {
                debugPrint("Purchase error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            let isActiveSubscription = result.subscription?.isActive() == true
            let isActiveNonRenewing = result.nonRenewingPurchase?.isActive() == true
            let hasActiveSubscription = Apphud.hasActiveSubscription()
            
            let success = isActiveSubscription || isActiveNonRenewing || hasActiveSubscription
            completion(success)
        }
    }

    /// Покупает расходуемый (consumable) продукт.
    /// - Parameters:
    ///   - product: Продукт типа `ApphudProduct`.
    ///   - completion: Замыкание, возвращающее `true`, если покупка успешна и активна.
    @MainActor
    public func purchaseConsumableProduct(product: ApphudProduct, completion: @escaping (Bool) -> Void) {
        Apphud.purchase(product) { result in
            guard result.error == nil else {
                completion(false)
                return
            }
            
            if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
