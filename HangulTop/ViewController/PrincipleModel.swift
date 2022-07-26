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
        PrincipleTexts(title: "한글은 누가 만들었을까?", subtitle: "", principleImage: nil, letters: [], info: "한글은 한국어의 공식문자이다.\n1443년 조선의 왕 세종이 한국어를 표기하기 위해 ‘훈민정음'이란 문자를 창제했고, 20세기 초반부터는 한글이란 명칭으로 부른다."),
        PrincipleTexts(title: "한글은 누가 만들었을까?", subtitle: "", principleImage: nil, letters: [], info: "세종대왕은 한자(표의문자)를 몰라 어려움을 겪는 백성들은 안타깝게 여겨 누구나 배우기 쉬운 글자(표음문자)을 만들었다."),
        PrincipleTexts(title: "한글은 누가 만들었을까?", subtitle: "", principleImage: nil, letters: [], info: "한글은 자음 14개와 모음 10개, 이렇게 글자 24개만 익히면 낱자와 소리를 연결해 글을 읽을 수 있다."),
        PrincipleTexts(title: "자음은 어떻게 만들어졌을까?", subtitle: "", principleImage: nil, letters: [], info: "세종대왕은 이,혀 입술 목 등 사람이 발음하는 기관의 모양을 본떠서 자음 글자를 만들었다.\n이렇게 다섯개의 자음 글자를 만들고, 이것을 바탕으로 나머지 자음 글자를 완성하셨다."),
        PrincipleTexts(title: "자음은 어떻게 만들어졌을까?", subtitle: "", principleImage: nil, letters: [], info: "다섯개의 기본 글자에 획을 더하여 강한 소리를 내는 자음들이 만들어졌다."),
        PrincipleTexts(title: "어금닛소리", subtitle: "혓등이 여린 입천장에 닿는 모양", principleImage: nil, letters: ["ㄱ", "ㅋ", "ㄲ"], info: ""),
        PrincipleTexts(title: "혓소리", subtitle: "혀끝이 윗니 바로 뒤의 잇몸에 닿는 모양", principleImage: nil, letters: ["ㄴ", "ㄷ", "ㅌ", "ㄹ", "ㄸ"], info: ""),
        PrincipleTexts(title: "입술소리", subtitle: "아랫입술과 윗입술이 다물어진 모양", principleImage: nil, letters: ["ㅁ", "ㅂ", "ㅍ", "ㅃ"], info: ""),
        PrincipleTexts(title: "잇소리", subtitle: "이의 모양", principleImage: nil, letters: ["ㅅ", "ㅈ", "ㅊ", "ㅉ", "ㅆ"], info: ""),
        PrincipleTexts(title: "목구멍소리", subtitle: "목구멍의 모양", principleImage: nil, letters: ["ㅇ", "ㅎ"], info: ""),
        PrincipleTexts(title: "모음은 어떻게 만들어졌을까?", subtitle: "", principleImage: nil, letters: [], info: "세종대왕은 (동양 철학에서) 만물의 근본 요소로 생각하는 세 가지를 보고 모음 글자를 만들었다.\n하늘의 모습을 본떠 .\n땅의 모습을 본떠 ㅡ\n사람의 모습을 본떠 ㅣ\n이것을 ‘천지인’이라고 부른다."),
        PrincipleTexts(title: "모음은 어떻게 만들어졌을까?", subtitle: "", principleImage: nil, letters: ["ㅡ", "∙", "ㅣ"], info: "이 모음들 중 ∙(아래 아)는 현재 단독으로 쓰이지 않는데, 그것은 이 글자가 나타내는 소리가 지금은 없어졌기 때문이다."),
        PrincipleTexts(title: "모음은 어떻게 만들어졌을까?", subtitle: "", principleImage: nil, letters: [], info: "나머지 모음글자는 어떻게 만들어졌을까?\nㅣ와 ㅡ에 .을 붙이는 방법으로 만들었다"),
        PrincipleTexts(title: "", subtitle: "", principleImage: nil, letters: [], info: "자음과 모음은 따로 떨어져 있어선 안된다\n함께 붙어있어야만 뜻이 있는 소리가 된다")
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
