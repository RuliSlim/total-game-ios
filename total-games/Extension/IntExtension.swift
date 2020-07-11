//
//  IntExtension.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation

extension Int {
    func convertToStringNumber() -> String {
        let string = String(self)
        var numInString = ""
        
        for (i, el) in string.reversed().enumerated() {
            if (i+1) % 3 == 0 && i != 0 && i != string.count - 1 {
                numInString = ".\(el)\(numInString)"
            } else {
                numInString = "\(el)\(numInString)"
            }
        }
        
        return numInString
    }
}
