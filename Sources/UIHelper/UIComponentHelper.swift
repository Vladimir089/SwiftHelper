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
    
    @MainActor
    public func customAnimateButton(bgColor: UIColor? = nil , bgImage: UIImage?, title: String?, titleColor: UIColor? = nil, fontTitleColor: UIFont? = nil, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil , borderColor: UIColor? = nil) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = cornerRadius ?? 0
        button.backgroundColor = bgColor ?? .clear
        button.titleLabel?.font = fontTitleColor ?? .systemFont(ofSize: 12, weight: .regular)
        button.setTitle(title ?? "", for: .normal)
        button.setBackgroundImage(bgImage ?? UIImage(), for: .normal)
        button.layer.borderColor = borderColor == nil ? UIColor.clear.cgColor : borderColor?.cgColor
        button.layer.borderWidth = (borderWidth == nil ? 0 : borderWidth) ?? 0
        button.animateButton()
        return button
    }
    
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
    
  
}




