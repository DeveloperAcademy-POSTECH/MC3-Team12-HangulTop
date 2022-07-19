//
//  BatchimModel.swift
//  HangulTop
//
//  Created by 기윤수 on 2022/07/18.
//

import Foundation
import UIKit

struct BatchimTexts {
    //+이걸 다른 struct에 쓰는 이유는? /이렇게 한 문서에 같이 써도 되나?
        let letters: [String]
        let info: String
}

struct BatchimModel {
    
    let contents = [
        BatchimTexts(letters: ["ㄱ", "ㅋ", "ㄲ"], info: "1악"),
        BatchimTexts(letters: ["ㄴ", "ㄵ", "ㄶ"], info: "2안"),
        BatchimTexts(letters: ["ㄷ", "ㅅ", "ㅆ", "ㅈ", "ㅊ", "ㅌ", "ㅎ"], info: "3앋"),
        BatchimTexts(letters: ["ㄹ", "ㄼ", "ㄽ", "ㄾ", "ㅀ"], info: "4알"),
        BatchimTexts(letters: ["ㅁ", "ㄻ", "ㄲ"], info: "5앎"),
        BatchimTexts(letters: ["ㅂ", "ㅍ", "ㅄ", "ㄿ"], info: "6압"),
        BatchimTexts(letters: ["ㅇ"], info: "7앙"),
    ]    
    
    
    var pageCount = 0


    // 컬렉션뷰에 들어갈 문자들의 배열 리턴하는 함수
    func getLetters() -> [String] {
        contents[pageCount].letters
    }

    //여기서 if []안에 있는게 n개면 -> 버튼을 이렇게 배치해라
    // 1, 3, 5
    // 2, 4, 6, 7
    
    
    
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
        self.pageCount -= 1
    }
}
