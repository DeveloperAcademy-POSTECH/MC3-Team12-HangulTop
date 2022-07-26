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
        BatchimTexts(letters: ["\u{11a8}", "\u{11bf}", "\u{11a9}", "\u{11aa}", "\u{11b0}"], info: ""),
        BatchimTexts(letters: ["\u{11ab}", "\u{11ac}", "\u{11ad}"], info: ""),
        BatchimTexts(letters: ["\u{11ae}", "\u{11ba}", "\u{11bb}", "\u{11bd}", "\u{11be}", "\u{11c0}", "\u{11c2}"], info: "ㄸ, ㅉ은 받침으로 쓰지 않는다."),
        BatchimTexts(letters: ["\u{11af}", "\u{11b2}", "\u{11b3}", "\u{11b4}", "\u{11b6}"], info: ""),
        BatchimTexts(letters: ["\u{11b7}", "\u{11b1}"], info: ""),
        BatchimTexts(letters: ["\u{11b8}", "\u{11c1}", "\u{11b9}", "\u{11b5}"], info: "ㅃ은 받침으로 쓰지 않는다."),
        BatchimTexts(letters: ["\u{11bc}"], info: "ㅇ은 첫소리에서 소릿값이 없고, 받침으로 올때만 소리를 인식할 수 있다."),
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
        if pageCount <= contents.count - 1 {
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
