//
//  Utils.swift
//  FarmciasTurnoSalto
//
//  Created by Juan Ariel on 15/3/17.
//  Copyright © 2017 Juan Ariel. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    //Hexadecimal to color
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
    
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
    
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
    
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

