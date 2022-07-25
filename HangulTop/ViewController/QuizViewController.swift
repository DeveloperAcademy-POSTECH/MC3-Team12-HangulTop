//
//  QuizViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/25.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var checkbutton: UIButton!
    var quizs = [String]()
    var answer = ""
    var selectedButton = UIButton()
    
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
        if selectedButton.titleLabel?.text == answer {
            checkbutton.backgroundColor = .green
            checkbutton.setTitle("Correct", for: .normal)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                // 다음문제
            }
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            checkbutton.backgroundColor = .red
            checkbutton.setTitle("Try again", for: .normal)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.checkbutton.setTitle("Check", for: .normal)
                self.checkbutton.backgroundColor = .systemGray5
                self.checkbutton.setTitleColor(.systemGray2, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizs = ["ㅏ", "ㅣ", "ㅐ", "ㅜ"]
        answer = "ㅣ"
        for i in 0..<4 {
            buttons[i].setTitle(quizs[i], for: .normal)
        }
    }
}
