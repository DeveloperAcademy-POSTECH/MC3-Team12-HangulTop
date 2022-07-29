//
//  HangulViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/28.
//

import UIKit
import AVFoundation

class HangulViewController: UIViewController{

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var mainLetter: UILabel!
    var check: Int = 0
    var setLet = [[14, 20, 21, 22, 23, 24, 25, 26, 27],[14, 22, 23, 24, 25, 26, 27],[14]]
    var hangul: String = "앙"
    let letters = ["\u{1100}","\u{110f}","\u{1101}"]
    let syllableArray = [["\u{1100}","\u{110f}","\u{1101}", "\u{1102}","\u{1103}","\u{1110}","\u{1105}","\u{1104}", "\u{1106}", "\u{1107}","\u{1111}","\u{1108}", "\u{1109}","\u{110c}","\u{110e}","\u{110d}","\u{110a}", "\u{110b}","\u{1112}"], ["ㅡ", "ㅣ", "ㅏ", "ㅓ", "ㅗ", "ㅜ", "ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅐ", "ㅔ", "ㅒ", "ㅖ", "ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"], ["\u{11a8}", "\u{11bf}", "\u{11a9}", "\u{11aa}", "\u{11b0}", "\u{11ab}", "\u{11ac}", "\u{11ad}", "\u{11ae}", "\u{11ba}", "\u{11bb}", "\u{11bd}", "\u{11be}", "\u{11c0}", "\u{11c2}", "\u{11af}", "\u{11b2}", "\u{11b3}", "\u{11b4}", "\u{11b6}", "\u{11b7}", "\u{11b1}", "\u{11b8}", "\u{11c1}", "\u{11b9}", "\u{11b5}", "\u{11bc}"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        mainLetter.text = hangul
        setButton()
        importButton()
        // Do any additional setup after loading the view.
    }
    
//    func setButton() {
//        for i in 0..<syllableArray[0].count {
//            buttons[i].setTitle(syllableArray[0][i], for: .normal)
//        }
//    }
//    func setBatchim() {
//        for i in 0..<syllableArray[2].count {
//            batchims[i].setTitle(syllableArray[0][i], for: .normal)
//        }
//    }
    
    @IBAction func viewSelect(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            check = 0
            setButton()
            importButton()
        }else if(sender.selectedSegmentIndex == 1) {
            check = 1
            setButton()
            importButton()
        }else if(sender.selectedSegmentIndex == 2) {
            check = 2
            setButton()
            importButton()
        }
    }
    
    @IBAction func selectButton(_ sender: UIButton){
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "\u{1100}")?.value ?? 0x1100
        if(buttonUni < 0x1113){ //자음일때
            let uni = buttonUni - 0x1100
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            let letter = ((uni * 21) + vowelUni) * 28 + batUni + 0xAC00
            hangul = String(UnicodeScalar(letter)!)
        }
        else if(buttonUni < 0x11c3){ //받침일때
            let uni = buttonUni - 0x11a7
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let letter = ((conUni * 21) + vowelUni) * 28 + uni + 0xAC00
            hangul = String(UnicodeScalar(letter)!)
        }
        else{ //모음일때
            let uni = buttonUni - 0x314f
            print("\(uni)")
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            print("\(conUni)")
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            print("\(batUni)")
            let letter = ((conUni * 21) + uni) * 28 + batUni + 0xAC00
            print("\(letter)")
            hangul = String(UnicodeScalar(letter)!)
            print("\(hangul)")
        }
        mainLetter?.text = hangul
        print("\(hangul)")
        pronounce(hangul)
    }
    
    func pronounce(_ letter: String) {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: letter)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        
        let audioSession = AVAudioSession.sharedInstance() //녹음 및 재생이 점유하고 있는 오디오 다시 가져오기
        try! audioSession.setCategory(
            AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers
        )
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    func setButton() {
        for i in 0..<buttons.count {
            buttons[i].isHidden = false
        }
        for j in 0..<setLet[check].count{
            buttons[setLet[check][j]].isHidden = true
        }
    }
    
    func importButton(){
        var j = 0
        for i in 0..<buttons.count {
            if(buttons[i].isHidden == false){
                buttons[i].setTitle(syllableArray[check][j], for: .normal)
                j += 1
            }
        }
    }

}
