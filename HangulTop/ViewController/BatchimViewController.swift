//
//  BatchimViewController.swift
//  HangulTop
//
//  Created by 기윤수 on 2022/07/16.
//

import UIKit
import AVFoundation

class BatchimViewController: UIViewController {
    
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var mainLetter: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBAction func buttonSelected(_ sender: UIButton) {
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㄱ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x11a7
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
        let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
        let letter = ((vowelUni * 21) + conUni) * 28 + uni + 0xAC00
        
        hangul = String(UnicodeScalar(letter)!)
        mainLetter.text = hangul
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var page1: UILabel!
    @IBOutlet weak var page2: UILabel!
    @IBOutlet weak var page3: UILabel!
    @IBOutlet weak var page4: UILabel!
    @IBOutlet weak var page5: UILabel!
    @IBOutlet weak var page6: UILabel!
    @IBOutlet weak var page7: UILabel!
    var pageArray: [UILabel] = []
    var hangul: String = "아"
    var batchimModel = BatchimModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageArray = [page1, page2, page3, page4, page5, page6, page7]
        setPageControl()
        updateUI()
        mainLetter.text = hangul
    }

    //다음 +1
    @IBAction func didTapNextButton(_ sender: UIButton) {
        batchimModel.nextView()
        if batchimModel.pageCount == batchimModel.contents.count {
            performSegue(withIdentifier: "finish_seg", sender: sender)
        } else {
            updateUI()
            setPageControl()
        }
    }

    //이전 -1
    @IBAction func didTapPrevButton(_ sender: UIButton) {
        batchimModel.prevView()
        updateUI()
        setPageControl()
    }
    
    func setPageControl() {
        if batchimModel.pageCount == 0 {
            prevButton.isHidden = true
        } else {
            prevButton.isHidden = false
        }
        for i in 0..<pageArray.count {
            pageArray[i].textColor = .gray
        }
        pageArray[batchimModel.pageCount].textColor = .black
    }
    
    func updateUI() {
        if batchimModel.getBtnCount() == 1 {
            button1.isHidden = true
            button2.isHidden = false
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
            button2.setTitle(batchimModel.getLetters()[0], for: .normal)
        }
        if batchimModel.getBtnCount() == 2 {
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = true
            button5.setTitle(batchimModel.getLetters()[0], for: .normal)
            button6.setTitle(batchimModel.getLetters()[1], for: .normal)
        }
        if batchimModel.getBtnCount() == 3 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
            button1.setTitle(batchimModel.getLetters()[0], for: .normal)
            button2.setTitle(batchimModel.getLetters()[1], for: .normal)
            button3.setTitle(batchimModel.getLetters()[2], for: .normal)
        }
        if batchimModel.getBtnCount() == 4 {
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            button4.setTitle(batchimModel.getLetters()[0], for: .normal)
            button5.setTitle(batchimModel.getLetters()[1], for: .normal)
            button6.setTitle(batchimModel.getLetters()[2], for: .normal)
            button7.setTitle(batchimModel.getLetters()[3], for: .normal)
        }
        if batchimModel.getBtnCount() == 5 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = true
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = true
            button1.setTitle(batchimModel.getLetters()[0], for: .normal)
            button2.setTitle(batchimModel.getLetters()[1], for: .normal)
            button4.setTitle(batchimModel.getLetters()[2], for: .normal)
            button5.setTitle(batchimModel.getLetters()[3], for: .normal)
            button6.setTitle(batchimModel.getLetters()[4], for: .normal)
        }
        if batchimModel.getBtnCount() == 7 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            button1.setTitle(batchimModel.getLetters()[0], for: .normal)
            button2.setTitle(batchimModel.getLetters()[1], for: .normal)
            button3.setTitle(batchimModel.getLetters()[2], for: .normal)
            button4.setTitle(batchimModel.getLetters()[3], for: .normal)
            button5.setTitle(batchimModel.getLetters()[4], for: .normal)
            button6.setTitle(batchimModel.getLetters()[5], for: .normal)
            button7.setTitle(batchimModel.getLetters()[6], for: .normal)
        }
        explanation.text = batchimModel.getInfo()
    }
}
