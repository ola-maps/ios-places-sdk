//
//  String+Extension.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 05/08/24.
//

import UIKit

extension String {
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}


