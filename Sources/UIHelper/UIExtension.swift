//
//  File.swift
//  SwiftHelper
//
//  Created by Владимир on 17.06.2025.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Добавляет анимацию нажатия на кнопку.
    ///
    /// При нажатии кнопка уменьшается в размере и воспроизводится лёгкий тактильный отклик (`UIImpactFeedbackGenerator`).
    /// Когда палец убирается или отменяется касание — кнопка возвращается к исходному размеру.
    public func animateButton() {
        self.addTarget(self, action: #selector(touchUpInside), for: .touchDown)
        self.addTarget(self, action: #selector(returnSize), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
    
    @objc private func touchUpInside() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
    @objc private func returnSize() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
}


extension UIImage {
    
    /// Изменяет размер изображения до заданных пропорций, сохраняя его аспектное соотношение.
    ///
    /// - Parameter targetSize: Целевой размер, в который необходимо вписать изображение.
    /// - Returns: Новое изображение, отмасштабированное с сохранением пропорций.
    ///
    /// Метод определяет соотношения сторон и масштабирует изображение по меньшему из коэффициентов (ширина или высота),
    /// чтобы избежать искажения. Отрисовка производится с учётом текущего `UIScreen.main.scale`.
    @MainActor
    public func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
