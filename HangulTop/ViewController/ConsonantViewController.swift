//
//  ConsonantViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/18.
//
import UIKit
import AVFoundation

class ConsonantViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    //녹음 재생 관련 변수들
    @IBOutlet weak var btnPlay: UIButton!
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    var audioRecorder : AVAudioRecorder!
    var isRecording = false
    //페이지 카운트 변수
    var pageNum = 0
    var indexCount: Int = 0
    //메인 버튼 글자 배열
    let syllableArray = [[["ㅡ", "ㅣ"], ["ㅏ", "ㅓ", "ㅗ", "ㅜ"], ["ㅑ", "ㅕ", "ㅛ", "ㅠ"], ["ㅐ", "ㅔ", "ㅒ", "ㅖ"], ["ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]],[["\u{1100}","\u{110f}","\u{1101}"], ["\u{1102}","\u{1103}","\u{1110}","\u{1105}","\u{1104}"], ["\u{1106}", "\u{1107}","\u{1111}","\u{1108}"], ["\u{1109}","\u{110c}","\u{110e}","\u{110d}","\u{110a}"], ["\u{110b}","\u{1112}"]],[["\u{11a8}", "\u{11bf}", "\u{11a9}", "\u{11aa}", "\u{11b0}"],["\u{11ab}", "\u{11ac}", "\u{11ad}"], ["\u{11ae}", "\u{11ba}", "\u{11bb}", "\u{11bd}", "\u{11be}", "\u{11c0}", "\u{11c2}"], ["\u{11af}", "\u{11b2}", "\u{11b3}", "\u{11b4}", "\u{11b6}"], ["\u{11b7}", "\u{11b1}"], ["\u{11b8}", "\u{11c1}", "\u{11b9}", "\u{11b5}"], ["\u{11bc}"]]]
    //자음 공부시 보이는 모음 배열
    let vowelArray = ["ㅡ", "ㅣ", "ㅏ", "ㅓ", "ㅗ", "ㅜ", "ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅐ", "ㅔ", "ㅒ", "ㅖ", "ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]
    //설명 배열
    var captionArray = [["ㅡ 는 항상 자음의 아래,ㅣ는 항상 자음의 오른편에 위치해야 한다.", "기본 모음에 · 이 하나 추가된 형태이다.", "기본 모음에 · 이 두개 추가된 형태이다.", "현대 국어에서 ㅐ 와 ㅔ 의 소리는 크게 구분되지 않는다.", "결합된 두 모음을 빠르게 읽으면 된다."],["-","-","-","-","-"],["-","-","ㄸ, ㅉ은 받침으로 쓰지 않는다.","-","-","ㅃ은 받침으로 쓰지 않는다.","ㅇ은 첫소리에서 소릿값이 없고, 받침으로 올때만 소리를 인식할 수 있다."]]
    
    var hangul: [String] = ["으", "가", "아"]
    @IBOutlet weak var mainLetter: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var consonantCollection: UICollectionView!
    @IBOutlet weak var explanationView: UILabel!
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        let mainUni = UnicodeScalar(hangul[indexCount])?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㄱ")?.value ?? 0x1100
        print("\(buttonUni)")
        if(buttonUni < 0x1113){ //자음일때
            let uni = buttonUni - 0x1100
            print("\(uni)")
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            let letter = ((uni * 21) + conUni) * 28 + batUni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        else if(buttonUni < 0x11c3){ //받침일때
            let uni = buttonUni - 0x11a7
            print("\(uni)")
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let letter = ((vowelUni * 21) + conUni) * 28 + uni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        else{ //모음일때
            let uni = buttonUni - 0x314f
            print("\(uni)")
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        mainLetter.text = hangul[indexCount]
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul[indexCount])
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        
        let audioSession = AVAudioSession.sharedInstance() //녹음 및 재생이 점유하고 있는 오디오 다시 가져오기
        try! audioSession.setCategory(
            AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers
        )
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
    
    //이전 버튼
    @IBAction func prevPage(_ sender: Any) {
        if pageNum > 0 {
            pageNum -= 1
            setButtonLayout()
            setPageControl()
            resultLabelInitalValue()
            setExplantion()
        }
    }
    
    //다음 버튼
    @IBAction func nextPage(_ sender: Any) {
        if pageNum < syllableArray[indexCount].count {
            
            pageNum += 1
            if pageNum < syllableArray[indexCount].count {
                resultLabelInitalValue()
            }
            if pageNum == syllableArray[indexCount].count { //성공 뷰
                switch indexCount {
                case 0:
                    UserDefaults.standard.set(true, forKey: "isVowel")
                case 1:
                    UserDefaults.standard.set(true, forKey: "isConsonant")
                case 2:
                    UserDefaults.standard.set(true, forKey: "isBatchim")
                default:
                    print("")
                }
                guard let vc =  storyboard?.instantiateViewController(identifier: "ConsonantEndViewController") as? ConsonantEndViewController else
                { return }
                
                vc.data = indexCount
//                vc.delegate = self
                
                
                self.navigationController!.pushViewController(vc, animated: true)
                //                performSegue(withIdentifier: "finish_seg", sender: sender)
            } else {
                setButtonLayout()
                setPageControl()
                setExplantion()
            }
        }
    }
    
    
    //페이지가 바뀔 때 마다 설명 바뀌게
    func setExplantion() {
        explanationView.text = captionArray[indexCount][pageNum]
    }
    func resultLabelInitalValue() {
        //배열의 0번째 아이템을 보여줌
        let mainUni = UnicodeScalar(hangul[indexCount])?.value
        let buttonUni = UnicodeScalar(syllableArray[indexCount][pageNum][0])?.value ?? 0x1100
        print("\(buttonUni)")
        if(buttonUni < 0x1113){ //자음일때
            let uni = buttonUni - 0x1100
            print("\(uni)")
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            let letter = ((uni * 21) + conUni) * 28 + batUni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        else if(buttonUni < 0x11c3){ //받침일때
            let uni = buttonUni - 0x11a7
            print("\(uni)")
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            let conUni = ((mainUni ?? 0xac01) - 0xac00) / 28 % 21
            let letter = ((vowelUni * 21) + conUni) * 28 + uni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        else{ //모음일때
            let uni = buttonUni - 0x314f
            print("\(uni)")
            let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
            let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
            let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
            hangul[indexCount] = String(UnicodeScalar(letter)!)
        }
        
        
        
        mainLetter.text = hangul[indexCount]
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
        let mainUni = UnicodeScalar(hangul[indexCount])?.value
        let buttonUni = UnicodeScalar(sender.titleLabel!.text ?? "ㅏ")?.value ?? 0x1100
        print("\(buttonUni)")
        let uni = buttonUni - 0x314f
        print("\(uni)")
        let vowelUni = ((mainUni ?? 0xac01) - 0xac00) / 28 / 21
        let batUni = ((mainUni ?? 0xac01) - 0xac00) % 28
        let letter = ((vowelUni * 21) + uni) * 28 + batUni + 0xAC00
        
        hangul[indexCount] = String(UnicodeScalar(letter)!)
        mainLetter.text = hangul[indexCount]
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: hangul[indexCount])
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        
        let audioSession = AVAudioSession.sharedInstance() //녹음 및 재생이 점유하고 있는 오디오 다시 가져오기
        try! audioSession.setCategory(
            AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers
        )
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        indexCount = appDelegate?.infos.indexCount ?? 0
        mainLetter.text = hangul[indexCount]
        setButtonLayout()
        pageArray = [page1, page2, page3, page4, page5]
        setPageControl()
        selectAudioFile()
        if(indexCount == 1){
            consonantCollection.isHidden = false
            explanationView.isHidden = true
        }else{
            consonantCollection.isHidden = true
            explanationView.isHidden = false
        }
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
        if syllableArray[indexCount][pageNum].count == 2 {
            button1.isHidden = true
            button2.isHidden = false
            button3.isHidden = false
            self.button2.setTitle(syllableArray[indexCount][pageNum][0], for: .normal)
            self.button3.setTitle(syllableArray[indexCount][pageNum][1], for: .normal)
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if syllableArray[indexCount][pageNum].count == 3 {
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            self.button5.setTitle(syllableArray[indexCount][pageNum][0], for: .normal)
            self.button6.setTitle(syllableArray[indexCount][pageNum][1], for: .normal)
            self.button7.setTitle(syllableArray[indexCount][pageNum][2], for: .normal)
        }
        if syllableArray[indexCount][pageNum].count == 4 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            self.button1.setTitle(syllableArray[indexCount][pageNum][0], for: .normal)
            self.button2.setTitle(syllableArray[indexCount][pageNum][1], for: .normal)
            self.button3.setTitle(syllableArray[indexCount][pageNum][2], for: .normal)
            self.button4.setTitle(syllableArray[indexCount][pageNum][3], for: .normal)
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
        }
        if syllableArray[indexCount][pageNum].count == 5 {
            button1.isHidden = true
            button2.isHidden = false
            button3.isHidden = false
            self.button2.setTitle(syllableArray[indexCount][pageNum][0], for: .normal)
            self.button3.setTitle(syllableArray[indexCount][pageNum][1], for: .normal)
            button4.isHidden = true
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            self.button5.setTitle(syllableArray[indexCount][pageNum][2], for: .normal)
            self.button6.setTitle(syllableArray[indexCount][pageNum][3], for: .normal)
            self.button7.setTitle(syllableArray[indexCount][pageNum][4], for: .normal)
        }
        if syllableArray[indexCount][pageNum].count == 7 {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
            button7.isHidden = false
            button1.setTitle(syllableArray[indexCount][pageNum][0], for: .normal)
            button2.setTitle(syllableArray[indexCount][pageNum][1], for: .normal)
            button3.setTitle(syllableArray[indexCount][pageNum][2], for: .normal)
            button4.setTitle(syllableArray[indexCount][pageNum][3], for: .normal)
            button5.setTitle(syllableArray[indexCount][pageNum][4], for: .normal)
            button6.setTitle(syllableArray[indexCount][pageNum][5], for: .normal)
            button7.setTitle(syllableArray[indexCount][pageNum][6], for: .normal)
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
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled =  true
        audioRecorder.prepareToRecord()
        
        audioPlayer.volume = 10
        
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
        audioPlayer.volume = 10
    }
    
    
    // '재생' 버튼을 클릭하였을 때
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    // 녹음 버튼을 클릭하면
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
            audioRecorder.record()
            
        } else { // 'Recording'이 거짓일 때 녹음을 중지하고 녹음된 소리를 출력
            audioRecorder.stop()
            initplay()
            audioPlayer.play()
        }
        
    }
    
}

