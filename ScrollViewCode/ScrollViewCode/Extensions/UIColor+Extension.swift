//
//  UIColor+Extension.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 29/10/25.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var hexFormatted = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

                if hexFormatted.hasPrefix("#") {
                    hexFormatted.remove(at: hexFormatted.startIndex)
                }

                var rgbValue: UInt64 = 0
                Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

                switch hexFormatted.count {
                case 6:
                    self.init(
                        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: alpha
                    )
                case 8:
                    self.init(
                        red: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                        blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                        alpha: CGFloat(rgbValue & 0x000000FF) / 255.0
                    )
                default:
                    self.init(white: 1.0, alpha: alpha) // fallback = white
                }
    }
    
    convenience init(hexa: UInt, alpha: CGFloat = 1) {
        self.init(
            red:   .init((hexa & 0xff0000) >> 16) / 255,
            green: .init((hexa & 0xff00  ) >>  8) / 255,
            blue:  .init( hexa & 0xff    )        / 255,
            alpha: alpha
        )
    }
}
