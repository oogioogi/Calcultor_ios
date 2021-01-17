//
//  KeyboardLayout.swift
//  Calcultor_ios
//
//  Created by 이용석: 조선소 전기 쟁이 on 2021/01/16.
//

/*
    계산기 키보드 문자를 배열로 만들어 놓았습니다.
     - 배열로 이렇게 만들어 놓으면 키를 쉽게 바꿀수 있으며 유지 보수도 쉬운것 같습니다.
     - 콜렉션 뷰 콘트롤로 키는 구현 했습니다.
*/

import Foundation

class KeyboardLayout {
    
    init() { }
    
    static var shared = KeyboardLayout()

    let normalNumbers = [
        ["√","%","∏","÷"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["AC","0",".","="],
    ]
    
}
