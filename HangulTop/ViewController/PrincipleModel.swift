//
//  PrincipleModel.swift
//  HangulTop
//
//  Created by Seulki Lee on 2022/07/18.
//

import Foundation
import UIKit

// 창제원리 뷰 로직이 담긴 구조체
struct PrincipleModel {
    
    // 화면에 나올 컨텐츠 데이터
    let contents = [
        PrincipleTexts(title: "Who invented Hangul?", subtitle: "", principleImage: nil, letters: [], info: "Hangul is the official letters of the Korean language.\nKing Sejong of the Joseon Dynasty in 1443 invented 'Hunminjeongeum to write the Korean language.\nFrom 20th Century on it is called Hangul."),
        PrincipleTexts(title: "Who invented Hangul?", subtitle: "", principleImage: nil, letters: [], info: "King Sejong had pity on his people who had difficulties reading Chinese characters, and thus invented Hangul which was much easier to learn."),
        PrincipleTexts(title: "Who invented Hangul?", subtitle: "", principleImage: nil, letters: [], info: "With only 14 consonants and 10 vowels, it enables people to read."),
        PrincipleTexts(title: "How were consonants invented?", subtitle: "", principleImage: nil, letters: [], info: "King Sejong made consonants based on the shape of human oral system.\nHe invented the first five consonants this way, and then made other consonants based on these."),
        PrincipleTexts(title: "How were consonants invented?", subtitle: "", principleImage: nil, letters: [], info: "Consonants with stronger sounds were made by adding strokes to the basic consonants."),
        PrincipleTexts(title: "Velar sound", subtitle: "The shape of the tongue touching the soft palate", principleImage: nil, letters: ["ㄱ", "ㅋ", "ㄲ"], info: ""),
        PrincipleTexts(title: "Lingual sound", subtitle: "The shape of the tip of the tongue touching the upper gum.", principleImage: nil, letters: ["ㄴ", "ㄷ", "ㅌ", "ㄹ", "ㄸ"], info: ""),
        PrincipleTexts(title: "Labial sound", subtitle: "Shape of lips", principleImage: nil, letters: ["ㅁ", "ㅂ", "ㅍ", "ㅃ"], info: ""),
        PrincipleTexts(title: " Dental sound", subtitle: "Shape of teeth", principleImage: nil, letters: ["ㅅ", "ㅈ", "ㅊ", "ㅉ", "ㅆ"], info: ""),
        PrincipleTexts(title: "Guttural sound", subtitle: "Shape of the throat", principleImage: nil, letters: ["ㅇ", "ㅎ"], info: ""),
        PrincipleTexts(title: "How were vowels invented?", subtitle: "", principleImage: nil, letters: [], info: "King Sejong created the vowel after the three fundamental elements of Eastern philosophy, also called 'cheonjiin'."),
        PrincipleTexts(title: "How were vowels invented?", subtitle: "", principleImage: nil, letters: ["ㅡ", "∙", "ㅣ"], info: "Among them, • is not solely used currently, because there is no sound that these letters represent."),
        PrincipleTexts(title: "How were vowels invented?", subtitle: "", principleImage: nil, letters: [], info: "How were the rest of the vowels created?\n∙ was attached to ㅣ and ㅡ."),
        PrincipleTexts(title: "", subtitle: "", principleImage: nil, letters: [], info: "Consonants and vowels cannot stay apart.\nThey need to be combined to be a sound that has a meaning.")
    ]
    
    // 큰 제목 리턴하는 함수
    func getTitle(pageCount: Int) -> String {
        contents[pageCount].title
    }
    
    // 작은 제목 리턴하는 함수
    func getSubtitle(pageCount: Int) -> String {
        contents[pageCount].subtitle
    }
    
    // 이미지(옵셔널) 리턴하는 함수
    func getImage(pageCount: Int) -> UIImageView? {
        contents[pageCount].principleImage
    }
    
    // 컬렉션뷰에 들어갈 문자들의 배열 리턴하는 함수
    func getLetters(pageCount: Int) -> [String] {
        contents[pageCount].letters
    }
    
    // 설명 부분 리턴하는 함수
    func getInfo(pageCount: Int) -> String {
        contents[pageCount].info
    }
}
