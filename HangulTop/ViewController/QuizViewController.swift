//
//  QuizViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/25.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var progressBar: PlainHorizontalProgressBar!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var checkbutton: UIButton!
    var quizs = [[String]]()
    var answers = [String]()
    var selectedButton = UIButton()
    var pageNum = 0
    
    @IBAction func buttonAction(_ sender: UIButton) {
        checkbutton.setTitleColor(.black, for: .normal)
        for button in buttons {
            if button == sender {
                selectedButton = button
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.green.cgColor
            } else {
                button.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func checkbuttonAction(_ sender: Any) {
        if selectedButton.titleLabel?.text == answers[pageNum] {
            checkbutton.backgroundColor = .green
            checkbutton.setTitle("Correct", for: .normal)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.pageNum += 1
                self.progressBar.progress += 0.1
                self.quizUpdate()
                self.buttonReset()
            }
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            checkbutton.backgroundColor = .red
            checkbutton.setTitle("Try again", for: .normal)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.buttonReset()
            }
        }
    }
    
    func quizUpdate() {
        for i in 0..<4 {
            buttons[i].setTitle(quizs[pageNum][i], for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNum = 0
        quizs.append(quizGenerator(1))
        quizs.append(quizGenerator(1))
        quizs.append(quizGenerator(1))
        quizs.append(quizGenerator(2))
        quizs.append(quizGenerator(2))
        quizs.append(quizGenerator(2))
        quizs.append(quizGenerator(2))
        quizs.append(quizGenerator(3))
        quizs.append(quizGenerator(3))
        quizs.append(quizGenerator(3))
        for i in 0..<quizs.count {
            answers.append(contentsOf: quizs[i].pick(1))
        }
        for i in 0..<4 {
            buttons[i].setTitle(quizs[0][i], for: .normal)
        }
    }
    
    func buttonReset() {
        checkbutton.setTitle("Check", for: .normal)
        checkbutton.backgroundColor = .systemGray5
        checkbutton.setTitleColor(.systemGray2, for: .normal)
        for button in buttons {
            button.layer.borderWidth = 0
        }
    }
    
    func quizGenerator(_ level: Int) -> [String] {
        let consonants = ["\u{1100}", "\u{110f}", "\u{1101}", "\u{1102}", "\u{1103}", "\u{1110}", "\u{1105}", "\u{1104}",  "\u{1106}", "\u{1107}", "\u{1111}", "\u{1108}", "\u{1109}", "\u{110c}", "\u{110e}", "\u{110d}", "\u{110a}",  "\u{110b}", "\u{1112}"]
        let vowels = ["ㅡ", "ㅣ", "ㅏ", "ㅓ", "ㅗ", "ㅜ", "ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅐ", "ㅔ", "ㅒ", "ㅖ", "ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]
        let batchims = [["\u{11a8}", "\u{11bf}", "\u{11a9}", "\u{11aa}", "\u{11b0}"], ["\u{11ab}", "\u{11ac}", "\u{11ad}"], ["\u{11ae}", "\u{11ba}", "\u{11bb}", "\u{11bd}", "\u{11be}", "\u{11c0}", "\u{11c2}"], ["\u{11af}", "\u{11b2}", "\u{11b3}", "\u{11b4}", "\u{11b6}"], ["\u{11b7}", "\u{11b1}"], ["\u{11b8}", "\u{11c1}", "\u{11b9}", "\u{11b5}"], ["\u{11bc}"]]
        
        var quizArray = [String]()
        if level == 1 {
            var vowel = vowels.pick(4)
            while (vowel.contains("ㅔ") && vowel.contains("ㅐ")) || (vowel.contains("ㅒ") && vowel.contains("ㅖ")) || (vowel.contains("ㅚ") && vowel.contains("ㅙ")) || (vowel.contains("ㅚ") && vowel.contains("ㅞ")) || (vowel.contains("ㅙ") && vowel.contains("ㅞ")) {
                vowel = vowels.pick(4)
            }
            return vowel
        }
        if level == 2 {
            let consonant = consonants.pick(4)
            var vowel = vowels.pick(4)
            while (vowel.contains("ㅔ") && vowel.contains("ㅐ")) || (vowel.contains("ㅒ") && vowel.contains("ㅖ")) || (vowel.contains("ㅚ") && vowel.contains("ㅙ")) || (vowel.contains("ㅚ") && vowel.contains("ㅞ")) || (vowel.contains("ㅙ") && vowel.contains("ㅞ")) {
                vowel = vowels.pick(4)
            }
            for i in 0..<4 {
                quizArray.append(combination(consonant: consonant[i], vowel: vowel[i]))
            }
            return quizArray
        }
        if level == 3 {
            let consonant = consonants.pick(1)
            let vowel = vowels.pick(4)
            let batchimCandidate = batchims.pick(4)
            var batchim = [String]()
            for i in 0..<4 {
                batchim.append(batchimCandidate[i].pick(1)[0])
            }
            for i in 0..<4 {
                quizArray.append(combination(consonant: consonant[0], vowel: vowel[i], batchim: batchim[i]))
            }
            return quizArray
        }
        return quizArray
    }
    
    func combination(consonant: String, vowel: String) -> String {
        let consonantIndex = (UnicodeScalar(consonant)?.value ?? 0x1100) - 0x1100
        let vowelIndex = (UnicodeScalar(vowel)?.value ?? 0x314f) - 0x314f
        
        let resultUni = ((consonantIndex * 21) + vowelIndex) * 28 + 0xAC00
        let resultStr = String(UnicodeScalar(resultUni)!)

        return resultStr
    }
    
    func combination(consonant: String, vowel: String, batchim: String) -> String {
        let consonantIndex = (UnicodeScalar(consonant)?.value ?? 0x1100) - 0x1100
        let vowelIndex = (UnicodeScalar(vowel)?.value ?? 0x314f) - 0x314f
        let batchimIndex = (UnicodeScalar(batchim)?.value ?? 0x11a7) - 0x11a7
        
        let resultUni = ((consonantIndex * 21) + vowelIndex) * 28 + batchimIndex + 0xAC00
        let resultStr = String(UnicodeScalar(resultUni)!)

        return resultStr
    }
}

extension Array {
    func pick(_ n: Int) -> [Element] {
        let shuffledIndices = indices.shuffled().prefix(upTo: n)
        return shuffledIndices.map {self[$0]}
    }
}

@IBDesignable
class PlainHorizontalProgressBar: UIView {
    @IBInspectable var color: UIColor? = .white
    var progress: CGFloat = 0.1 {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width*progress, height: rect.height))
        let progressLayer = CALayer()
        progressLayer.frame = progressRect

        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color?.cgColor
    }
}
