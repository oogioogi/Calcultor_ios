//
//  KeyboardLayout.swift
//  Calcultor_ios
//
//  Created by 이용석 on 2021/01/16.
//

import Foundation

class KeyboardLayout {
    
    init() { }
    
    static var shared = KeyboardLayout()

    let normalNumbers = [
        ["√","%","∏","÷"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["C","0",".","="],
    ]
    
}
