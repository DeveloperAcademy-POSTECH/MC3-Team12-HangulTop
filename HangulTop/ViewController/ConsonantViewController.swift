//
//  ConsonantViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/18.
//

import UIKit
import AVFoundation

class ConsonantViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var btnPlay: UIButton!
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    var audioRecoder : AVAudioRecorder!
    var isRecording = false
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
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㄱ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x1100
        print("\(uni)")
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
            resultLabelInitalValue()
        }
    }
    @IBAction func nextPage(_ sender: Any) {
        if pageNum < consonantArray.count {
            
            pageNum += 1
            if pageNum < consonantArray.count {
                resultLabelInitalValue()
            }
            
            if pageNum == consonantArray.count {
                performSegue(withIdentifier: "finish_seg", sender: sender)
            } else {
                setButtonLayout()
                setPageControl()
            }
        }
    }
    
    func resultLabelInitalValue() {
        //배열의 0번째 아이템을 보여줌
        let mainUni = UnicodeScalar(hangul)?.value
        let buttonUni = UnicodeScalar(consonantArray[pageNum][0])?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x1100
        print("\(uni)")
        let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((uni * 21) + conUni) * 28 + batUni + 0xAC00
        hangul = String(UnicodeScalar(letter)!)

        mainLetter.text = hangul
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
        if !isRecording { // 재생 모드일 때(녹음 모드가 아니라면)
            initplay()
        } else { // 녹음 모드일 때
            initRecord()
        }

        btnPlay.isHidden = true
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
    // 재생 모드와 녹음 모드에 따라 다른 파일을 선택함
    func selectAudioFile(){
        if !isRecording { // 재생 모드일 때
            audioFile = Bundle.main.url(forResource: "Sound", withExtension: "mp3")
        } else { // 녹음 모드일 때
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // 녹음 모드의 초기화
    func initRecord(){
        let recordSettings = [AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
                   AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                        AVEncoderBitRateKey : 320000,
                      AVNumberOfChannelsKey : 2,
                            AVSampleRateKey : 44100.0 ] as [String : Any]
        do {
            audioRecoder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecoder.delegate = self
        audioRecoder.isMeteringEnabled =  true
        audioRecoder.prepareToRecord()
        
        audioPlayer.volume = 5

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
    }
    
    // 재생 모드의 초기화
    func initplay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        audioPlayer.delegate = self // audioPlayer의 델리게이트는 self
        audioPlayer.prepareToPlay() // prepareToPlay() 실행
        audioPlayer.volume = 5
    }
    
    
    // '재생' 버튼을 클릭하였을 때
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    
    
//    // 스위치를 ON/Off하여 녹음모드 인지 재생 모드인지를 결정함
//    @IBAction func swRecordMode(_ sender: UISwitch) {
//        if sender.isOn { // 녹음 모드일 때
//            audioPlayer.stop()
//            audioPlayer.currentTime = 0
//            isRecordMode = true
//            btnRecord.isEnabled = true
//        } else { // 재생 모드일 때
//            isRecordMode = false
//            btnRecord.isEnabled = false
//        }
//        selectAudioFile() // 모드에 따라 오디오 파일을 선택함
//
//        // 모드에 따라 재생 초기화 또는 녹음 초기화를 수행함
//        if !isRecordMode { // 녹음 모드가 아닐 때, 즉 재생 모드일 때
//            initplay()
//        } else { // 녹음 모드일 때
//            initRecord()
//        }
//    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if !isRecording { // 녹음 모드가 아닐 때, 즉 재생 모드일 때
            isRecording = true
            selectAudioFile()
            initRecord()
            
        } else { // 녹음 모드일 때
            isRecording = false
        }
        btnPlay.isHidden = false
        if isRecording { // 'Recording'이 참일 때 녹음을 시작함
            audioRecoder.record()
           
        } else { // 'Recording'이 거짓일 때 녹음을 중지함
            audioRecoder.stop()
            initplay()
            audioPlayer.play()
        }

    }
    
}

