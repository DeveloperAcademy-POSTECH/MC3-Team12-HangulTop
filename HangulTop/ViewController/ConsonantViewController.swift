//
//  ConsonantViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/18.
//

import UIKit
import AVFoundation

class ConsonantViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    var audioRecorder : AVAudioRecorder!
    var isRecorderMode = false
    var time: Timer!
    
    var pageNum = 0
    let consonantArray = [["\u{1100}","\u{110f}","\u{1101}"], ["\u{1102}","\u{1103}","\u{1110}","\u{1105}","\u{1104}"], ["\u{1106}", "\u{1107}","\u{1111}","\u{1108}"], ["\u{1109}","\u{110c}","\u{110e}","\u{110d}","\u{110a}"], ["\u{110b}","\u{1112}"]]
    let vowelArray = ["ㅡ", "ㅣ", "ㅏ", "ㅓ", "ㅗ", "ㅜ", "ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅐ", "ㅔ", "ㅒ", "ㅖ", "ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]
    var hangul: String = "가"
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
        var buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㄱ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x1100
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
        let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((uni * 21) + conUni) * 28 + batUni + 0xAC00
        
        hangul = String(UnicodeScalar(letter)!)
        mainLetter.text = hangul
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    @IBOutlet weak var page1: UILabel!
    @IBOutlet weak var page2: UILabel!
    @IBOutlet weak var page3: UILabel!
    @IBOutlet weak var page4: UILabel!
    @IBOutlet weak var page5: UILabel!
    var pageArray: [UILabel] = []
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBAction func prevPage(_ sender: Any) {
        if pageNum > 0 {
            pageNum -= 1
            setButtonLayout()
            setPageControl()
        }
    }
    @IBAction func nextPage(_ sender: Any) {
        if pageNum < consonantArray.count {
            pageNum += 1
            if pageNum == consonantArray.count {
                performSegue(withIdentifier: "finish_seg", sender: sender)
            } else {
                setButtonLayout()
                setPageControl()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vowelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        cell.cellButton.setTitle(vowelArray[indexPath.row], for: .normal)
        cell.cellButton.addTarget(self, action: #selector(getVowel(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func getVowel(sender: UIButton){
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㅏ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x314f
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
        let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
        
        hangul = String(UnicodeScalar(letter)!)
        mainLetter.text = hangul
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonLayout()
        pageArray = [page1, page2, page3, page4, page5]
        setPageControl()
        selectAudioFile()
        if (!isRecorderMode) {
            initPlay()
            //            btnRecord.isEnabled = false
            //            lbRecordTime.isEnabled = false
            
        }else{
            initRecord()
        }
    }
    
    func setPageControl() {
        if pageNum == 0 {
            prevBtn.isHidden = true
        } else {
            prevBtn.isHidden = false
        }
        for i in 0..<pageArray.count {
            pageArray[i].textColor = .gray
        }
        pageArray[pageNum].textColor = .black
    }
    
    func setButtonLayout() {
        if consonantArray[pageNum].count == 2 {
            button1.isHidden = true
            button2.isHidden = false
            button3.isHidden = false
            self.button2.setTitle(consonantArray[pageNum][0], for: .normal)
            self.button3.setTitle(consonantArray[pageNum][1], for: .normal)
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if consonantArray[pageNum].count == 3 {
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            self.button5.setTitle(consonantArray[pageNum][0], for: .normal)
            self.button6.setTitle(consonantArray[pageNum][1], for: .normal)
            self.button7.setTitle(consonantArray[pageNum][2], for: .normal)
        }
        if consonantArray[pageNum].count == 4 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            self.button1.setTitle(consonantArray[pageNum][0], for: .normal)
            self.button2.setTitle(consonantArray[pageNum][1], for: .normal)
            self.button3.setTitle(consonantArray[pageNum][2], for: .normal)
            self.button4.setTitle(consonantArray[pageNum][3], for: .normal)
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if consonantArray[pageNum].count == 5 {
            button1.isHidden = true
            button2.isHidden = false
            button3.isHidden = false
            self.button2.setTitle(consonantArray[pageNum][0], for: .normal)
            self.button3.setTitle(consonantArray[pageNum][1], for: .normal)
            button4.isHidden = true
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            self.button5.setTitle(consonantArray[pageNum][2], for: .normal)
            self.button6.setTitle(consonantArray[pageNum][3], for: .normal)
            self.button7.setTitle(consonantArray[pageNum][4], for: .normal)
        }
        
    }
    
    
}

