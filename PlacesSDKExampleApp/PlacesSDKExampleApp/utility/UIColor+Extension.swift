//
//  UIColor+Extension.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 07/08/24.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let bitwiseRed = Int(color >> 16) & mask
        let bitwiseGreen = Int(color >> 8) & mask
        let bitwiseblue = Int(color) & mask
        let red   = CGFloat(bitwiseRed) / 255.0
        let green = CGFloat(bitwiseGreen) / 255.0
        let blue  = CGFloat(bitwiseblue) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format: "#%06x", rgb)
    }
}
