//
//  VowelViewController.swift
//  HangulTop
//
//  Created by baek seohyeon on 2022/07/16.
//

import UIKit


class VowelViewController: UIViewController {
    
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    
    //모음 배열
    var vowelsArray: [[String]] = [["ㅡ", "ㅣ"], ["ㅏ", "ㅓ", "ㅗ", "ㅜ"], ["ㅑ", "ㅕ", "ㅛ", "ㅠ"], ["ㅐ", "ㅔ", "ㅒ", "ㅖ"], ["ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]]
    //설명 배열
    var caption: [String] = ["ㅡ 는 항상 자음의 아래,ㅣ는 항상 자음의 오른편에 위치해야 한다.", "기본 모음에 · 이 하나 추가된 형태이다.", "기본 모음에 · 이 두개 추가된 형태이다.", "현대 국어에서 ㅐ 와 ㅔ 의 소리는 크게 구분되지 않는다.", "결합된 두 모음을 빠르게 읽으면 된다."]
    //페이지 카운트
    var pageCount: Int = 0


    //첫로드 화면
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vowel"
        explanationView()
        buttonView()
        resultLabelInitalValue()
    }
    
    //이전버튼 누를 시 액션
    @IBAction func pressedPrevButton(_ sender: UIButton) {
        //페이지 카운트 1씩 감소
        pageCount -= 1
        explanationView()
        buttonView()
        resultLabelInitalValue()
    }
    
    //다음버튼 누를 시 액션
    @IBAction func pressedNextButton(_ sender: UIButton) {
        //페이지 카운트 1씩 증가
        pageCount += 1
        explanationView()
        buttonView()
        resultLabelInitalValue()
    }
    
    //버튼 탭할 시 액션
    @IBAction func didTapButton(_ sender: UIButton) {
        //모음버튼 눌렀을 때 누른 버튼의 타이틀을 결과값에 그대로 가져옴
        resultLabel.text = sender.titleLabel?.text
    }
    
    
    //TODO: - 함수는 다른 파일로 옮겨 코드 길이를 짧게 관리 할 수 있을까?
    //1. 화면 전환 시 초기 결과값 세팅 함수
    func resultLabelInitalValue() {
        //배열의 0번째 아이템을 보여줌
        resultLabel.text = vowelsArray[pageCount][0]
    }
    
    
    //2. 모음 설명 전환 함수
    func explanationView() {
        //캡션의 n번째 텍스트를 불러옴
        self.explanation.text = caption[pageCount]
     }


    //3. 버튼 뷰 전환 함수
    func buttonView() {
        //모음 갯수 카운트에 따라 버튼 배열 보여줌
        if vowelsArray[pageCount].count == 2 {
            //TODO: -  버튼 나타내기위해 true,false 이렇게만 써야하는지? 더 좋은 방법 고안하기
            button1.isHidden = true
            self.button2.setTitle(vowelsArray[pageCount][0], for: .normal)
            self.button3.setTitle(vowelsArray[pageCount][1], for: .normal)
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if vowelsArray[pageCount].count == 4 {
            
            button1.isHidden = false
            self.button1.setTitle(vowelsArray[pageCount][0], for: .normal)
            button2.isHidden = false
            self.button2.setTitle(vowelsArray[pageCount][1], for: .normal)
            button3.isHidden = false
            self.button3.setTitle(vowelsArray[pageCount][2], for: .normal)
            button4.isHidden = false
            self.button4.setTitle(vowelsArray[pageCount][3], for: .normal)
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if vowelsArray[pageCount].count == 7 {
            
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            self.button1.setTitle(vowelsArray[pageCount][3], for: .normal)
            self.button2.setTitle(vowelsArray[pageCount][4], for: .normal)
            self.button3.setTitle(vowelsArray[pageCount][5], for: .normal)
            self.button4.setTitle(vowelsArray[pageCount][6], for: .normal)
            self.button5.setTitle(vowelsArray[pageCount][0], for: .normal)
            self.button6.setTitle(vowelsArray[pageCount][1], for: .normal)
            self.button7.setTitle(vowelsArray[pageCount][2], for: .normal)
        }
        
    }
    
}
    
