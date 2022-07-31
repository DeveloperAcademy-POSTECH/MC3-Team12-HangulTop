//
//  InformationModalModel.swift
//  HangulTop
//
//  Created by Seulki Lee on 2022/07/29.
//

import UIKit

struct InformationModalModel {
    
    let titleArray: [String] = [
        "Velar sound", "Lingual sound", "Labial sound", " Dental sound", "Guttural sound"
    ]
    
    let infoArray: [String] = [
        "The shape of the tongue touching the soft palate", "The shape of the tip of the tongue touching the upper gum", "The shape of lips", "The shape of teeth", "The shape of the throat"
    ]
    
    let lettersArray: [[String]] = [
        ["ㄱ", "ㅋ", "ㄲ"], ["ㄴ", "ㄷ", "ㅌ", "ㄹ", "ㄸ"], ["ㅁ", "ㅂ", "ㅍ", "ㅃ"], ["ㅅ", "ㅈ", "ㅊ", "ㅉ", "ㅆ"], ["ㅇ", "ㅎ"]
    ]
    
    let imageArray: [String] = ["ㄱ", "ㄴ", "ㅁ", "ㅅ", "ㅇ"]
}
