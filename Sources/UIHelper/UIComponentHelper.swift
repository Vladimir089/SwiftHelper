//
//  File.swift
//  SwiftHelper
//
//  Created by Владимир on 17.06.2025.
//

import Foundation
import SnapKit
import UIKit

public class UIComponentHelper {
    
    /// Создаёт анимированную кнопку с возможностью настройки внешнего вида.
    /// - Parameters:
    ///   - bgColor: Цвет фона кнопки. По умолчанию — прозрачный.
    ///   - bgImage: Фоновое изображение кнопки.
    ///   - title: Текст заголовка кнопки.
    ///   - titleColor: Цвет заголовка. (Не используется напрямую — потенциально можно добавить.)
    ///   - fontTitleColor: Шрифт заголовка. По умолчанию `.systemFont(ofSize: 12, weight: .regular)`.
    ///   - cornerRadius: Радиус скругления углов. По умолчанию 0.
    ///   - borderWidth: Толщина границы. По умолчанию 0.
    ///   - borderColor: Цвет границы. По умолчанию — прозрачный.
    /// - Returns: Настроенная и анимированная `UIButton`.
    @MainActor
    public func customAnimateButton(bgColor: UIColor? = nil , bgImage: UIImage?, title: String?, titleColor: UIColor? = nil, fontTitleColor: UIFont? = nil, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil , borderColor: UIColor? = nil) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = cornerRadius ?? 0
        button.backgroundColor = bgColor ?? .clear
        button.setTitleColor(titleColor ?? .white, for: .normal)
        button.titleLabel?.font = fontTitleColor ?? .systemFont(ofSize: 12, weight: .regular)
        button.setTitle(title ?? "", for: .normal)
        button.setBackgroundImage(bgImage ?? UIImage(), for: .normal)
        button.layer.borderColor = borderColor == nil ? UIColor.clear.cgColor : borderColor?.cgColor
        button.layer.borderWidth = (borderWidth == nil ? 0 : borderWidth) ?? 0
        button.animateButton()
        return button
    }
    
    /// Создаёт UIImageView с кастомными параметрами.
    /// - Parameters:
    ///   - image: Изображение для отображения.
    ///   - isClipped: Обрезать ли содержимое по границам. По умолчанию `true`.
    ///   - mode: Режим отображения изображения (`contentMode`).
    ///   - cornerRadius: Радиус скругления углов. По умолчанию 0.
    ///   - borderWidth: Толщина границы. По умолчанию 0.
    ///   - borderColor: Цвет границы. По умолчанию — прозрачный.
    /// - Returns: Настроенный `UIImageView`.
    @MainActor
    public func customImageView(image: UIImage, isClipped: Bool? = nil, mode: UIImageView.ContentMode, cornerRadius: CGFloat? = 0, borderWidth: CGFloat? = nil , borderColor: UIColor? = nil) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.layer.borderColor = borderColor == nil ? UIColor.clear.cgColor : borderColor?.cgColor
        imageView.layer.borderWidth = (borderWidth == nil ? 0 : borderWidth) ?? 0
        imageView.contentMode = mode
        imageView.clipsToBounds = isClipped ?? true
        imageView.layer.cornerRadius = cornerRadius ?? 0
        return imageView
    }
    
    /// Создаёт `UILabel` с настраиваемыми параметрами.
    /// - Parameters:
    ///   - text: Отображаемый текст.
    ///   - font: Шрифт текста.
    ///   - color: Цвет текста. По умолчанию — белый.
    ///   - textAligment: Выравнивание текста. По умолчанию `.left`.
    ///   - numberLines: Количество строк. По умолчанию — 1.
    /// - Returns: Настроенный `UILabel`.
    @MainActor
    public func customLabel(text: String, font: UIFont, color: UIColor? = nil, textAligment: NSTextAlignment? = nil, numberLines: Int? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color ?? .white
        label.font = font
        label.textAlignment = textAligment ?? .left
        label.numberOfLines = numberLines ?? 1
        return label
    }


    /// Вызывает вибрацию с указаным стилем.
    /// - Parameter type: HapticEffect
    @MainActor
    public func applyHapticEffect(type: HapticEffect) {
        switch type {
        case .Succes:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .Warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .Error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .Light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred(intensity: 1.0)
        case .Medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred(intensity: 1.0)
        case .Heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred(intensity: 1.0)
        case .Rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred(intensity: 1.0)
        case .Soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred(intensity: 1.0)
        case .Selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    public enum HapticEffect {
        case Succes
        case Warning
        case Error
        case Light
        case Medium
        case Heavy
        case Rigid
        case Soft
        case Selection
    }
}




