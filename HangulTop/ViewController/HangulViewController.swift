//
//  HangulViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/28.
//

import UIKit
import AVFoundation

class HangulViewController: UIViewController {

    @IBOutlet weak var mainLetter: UILabel!
    @IBOutlet weak var consonantView: UIView!
    @IBOutlet weak var vowelView: UIView!
    @IBOutlet weak var batchimView: UIView!
    var hangul: String = "가"
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLetter.text = hangul
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewSelect(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            vowelView.isHidden = false
            consonantView.isHidden = true
            batchimView.isHidden = true
        }else if(sender.selectedSegmentIndex == 1) {
            vowelView.isHidden = true
            consonantView.isHidden = false
            batchimView.isHidden = true
        }else if(sender.selectedSegmentIndex == 2) {
            vowelView.isHidden = true
            consonantView.isHidden = true
            batchimView.isHidden = false
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
