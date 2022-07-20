//
//  VowelViewController.swift
//  HangulTop
//
//  Created by baek seohyeon on 2022/07/16.
//

import UIKit
import AVFoundation

class VowelViewController: UIViewController {
    
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var vowelImage: UIImageView!
    @IBOutlet weak var firstNextButton: UIButton!
    @IBOutlet weak var paging: UILabel!
    @IBOutlet weak var bottomControlButtons: UIView!
    
    var hangul: String = "아"
    //첫번째 페이지 설명
    var firstPageCaption: String = "모음은 총 21개로, 기본 모음 10개와 \n 복합 모음 11개로 구성 되어있다.\n 자음 'ㅇ'은 첫번째(초성)로 올 때 음가가 없기 때문에 모음 앞의 공백을 표시하는 기호로 쓰인다."
    //모음 배열
    var vowelsArray: [[String]] = [["ㅡ", "ㅣ"], ["ㅏ", "ㅓ", "ㅗ", "ㅜ"], ["ㅑ", "ㅕ", "ㅛ", "ㅠ"], ["ㅐ", "ㅔ", "ㅒ", "ㅖ"], ["ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]]
    //설명 배열
    var caption: [String] = ["ㅡ 는 항상 자음의 아래,ㅣ는 항상 자음의 오른편에 위치해야 한다.", "기본 모음에 · 이 하나 추가된 형태이다.", "기본 모음에 · 이 두개 추가된 형태이다.", "현대 국어에서 ㅐ 와 ㅔ 의 소리는 크게 구분되지 않는다.", "결합된 두 모음을 빠르게 읽으면 된다."]
    //페이징 배열
    var pagingIndex: [String] = ["ㅣ", "ㅏ", "ㅑ", "ㅐ", "ㅘ"]
    //페이지 카운트
    var pageCount: Int = 0


    //첫로드 화면
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vowel"
        firstPageView()
        resultLabel.text = hangul
    }
    //MARK: - 버튼 액션
    //첫번째 넥스트 버튼 누를 시 액션
    @IBAction func didTapFirstNextButton(_ sender: Any) {
        vowelStartView()
    }
    
    //이전버튼 누를 시 액션
    @IBAction func pressedPrevButton(_ sender: UIButton) {
        //TODO: ishidden을 사용하지않고 다시 첫번째 페이지를 불러오는 방법은 없을까?
        if pageCount == 0 {
            self.firstPageView()
            firstNextButton.isHidden = false
            informationButton.isHidden = true
            resultLabel.isHidden = true
            vowelImage.isHidden = false
            paging.isHidden = true
        } else {
            //페이지 카운트 1씩 감소
            pageCount -= 1
            explanationView()
            buttonView()
            resultLabelInitalValue()
        }
        
    }
    
    //다음버튼 누를 시 액션
    @IBAction func pressedNextButton(_ sender: UIButton) {
        //페이지 카운트 1씩 증가
        if pageCount < vowelsArray.count {
            pageCount += 1
        }
        if pageCount == vowelsArray.count {
            performSegue(withIdentifier: "finish_seg", sender: sender)
        } else {
            explanationView()
            buttonView()
            resultLabelInitalValue()
        }
    }
    
    //모음 버튼 탭할 시 액션
    @IBAction func didTapButton(_ sender: UIButton) {
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㅏ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x314f
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
       
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
        hangul = String(UnicodeScalar(letter)!)
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
        //모음버튼 눌렀을 때 누른 버튼의 타이틀을 결과값에 그대로 가져옴
        resultLabel.text = hangul
    }
    //MARK: - 뷰 관련 함수
    
    //1. 모음에 관한 첫 설명 뷰
    func firstPageView() {
        bottomControlButtons.isHidden = true
        paging.isHidden = true
        resultLabel.isHidden = true
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        button5.isHidden = true
        button6.isHidden = true
        button7.isHidden = true
        nextButton.isHidden = true
        prevButton.isHidden = true
        informationButton.isHidden = true
        self.explanation.text = firstPageCaption
        self.vowelImage.image = UIImage(named: "vowel")
    }
    
    //2. 모음 공부 시작 뷰
    func vowelStartView() {
        bottomControlButtons.isHidden = false
        paging.isHidden = false
        resultLabel.isHidden = false
        nextButton.isHidden = false
        prevButton.isHidden = false
        informationButton.isHidden = false
        firstNextButton.isHidden = true
        vowelImage.isHidden = true
        pageCount = 0
        explanationView()
        buttonView()
        resultLabelInitalValue()
    }
    
    //3. 페이징 뷰
    //MARK: - 모음 컨텐츠 속 전환 관련 함수
    //TODO: 함수는 다른 파일로 옮겨 코드 길이를 짧게 관리 할 수 있을까?
   
    //1. 화면 전환 시 초기 결과값 세팅 함수
    func resultLabelInitalValue() {
        //배열의 0번째 아이템을 보여줌
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(vowelsArray[pageCount][0])?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x314f
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
       
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
        hangul = String(UnicodeScalar(letter)!)

        resultLabel.text = hangul
    }
    
    //2. 모음 설명 전환 함수
    func explanationView() {
        //캡션의 n번째 텍스트를 불러옴
        self.explanation.text = caption[pageCount]
        self.paging.text = pagingIndex[pageCount]
     }
    
    //3. 버튼 뷰 전환 함수
    func buttonView() {
        //모음 갯수 카운트에 따라 버튼 배열 보여줌
        if vowelsArray[pageCount].count == 2 {
            //TODO: 버튼 나타내기위해 true,false 이렇게만 써야하는지? 더 좋은 방법 고안하기
            button1.isHidden = true
            button2.isHidden = false
            self.button2.setTitle(vowelsArray[pageCount][0], for: .normal)
            button3.isHidden = false
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
    
