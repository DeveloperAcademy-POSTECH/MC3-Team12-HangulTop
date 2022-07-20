//
//  BatchimViewController.swift
//  HangulTop
//
//  Created by 기윤수 on 2022/07/16.
//

import UIKit

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
        mainLetter.text = sender.titleLabel?.text ?? "error"
    }
    
    var batchimModel = BatchimModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    //다음 +1
    @IBAction func didTapNextButton(_ sender: UIButton) {
        batchimModel.nextView()
        updateUI()
    }

    //이전 -1
    @IBAction func didTapPrevButton(_ sender: UIButton) {
        batchimModel.prevView()
        updateUI()
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
    
    func setButtonLayout() {
        
    }
}
