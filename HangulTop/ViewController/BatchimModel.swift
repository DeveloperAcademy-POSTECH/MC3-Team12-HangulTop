//
//  BatchimModel.swift
//  HangulTop
//
//  Created by 기윤수 on 2022/07/18.
//

import Foundation
import UIKit

struct BatchimTexts {
    let letters: [String]
    let info: String
}

struct BatchimModel {
    
    let contents = [
        BatchimTexts(letters: ["ㄱ", "ㅋ", "ㄲ"], info: ""),
        BatchimTexts(letters: ["ㄴ", "ㄵ", "ㄶ"], info: ""),
        BatchimTexts(letters: ["ㄷ", "ㅅ", "ㅆ", "ㅈ", "ㅊ", "ㅌ", "ㅎ"], info: "ㄸ, ㅉ은 받침으로 쓰지 않는다."),
        BatchimTexts(letters: ["ㄹ", "ㄼ", "ㄽ", "ㄾ", "ㅀ"], info: ""),
        BatchimTexts(letters: ["ㅁ", "ㄻ", "ㄲ"], info: ""),
        BatchimTexts(letters: ["ㅂ", "ㅍ", "ㅄ", "ㄿ"], info: "ㅃ은 받침으로 쓰지 않는다."),
        BatchimTexts(letters: ["ㅇ"], info: "ㅇ은 첫소리에서 소릿값이 없고, 받침으로 올때만 소리를 인식할 수 있다."),
    ]
    
    var pageCount = 0
    
    func getBtnCount() -> Int {
        contents[pageCount].letters.count
    }
    
    func getLetters() -> [String] {
        contents[pageCount].letters
    }
    
    // 설명 부분 리턴하는 함수
    func getInfo() -> String {
        contents[pageCount].info
    }
    
    // 다음 뷰로 넘어갈 때 페이지 카운트 + 1 해주는 함수
    mutating func nextView() {
        if pageCount < contents.count - 1 {
            self.pageCount += 1
        }
    }
    
    // 이전 뷰로 돌아갈 때 페이지 카운트 - 1 해주는 함수
    mutating func prevView() {
        if pageCount > 0 {
            self.pageCount -= 1
        }
    }
}
