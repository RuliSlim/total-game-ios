//
//  StringExtension.swift
//  total-games
//
//  Created by Ruli on 16/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation

extension String {
    func description() -> String {
        var string = ""
        var skip = false
        
        for str in self {
            if str == "<" {
                skip = true
            }
            
            if str == ">" {
                skip = false
            }
            
            if !skip && str != ">" {
                string += String(str)
            }
        }
        
        return string
    }
}
