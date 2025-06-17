//
//  Apphud.swift
//  UniversalSwiftHelper
//
//  Created by Владимир on 13.06.2025.
//

import Foundation
import ApphudSDK
import SnapKit

public final class SwiftHelper {
    ///ApphudHelper для работы с Apphud SDK.
    @MainActor public static let apphudHelper = ApphudHelper()
    
    ///UiHelper для создания элементов
    @MainActor public static let uiHelper = UIComponentHelper()
}


