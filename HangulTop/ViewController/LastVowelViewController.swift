//
//  LastVowelViewController.swift
//  HangulTop
//
//  Created by baek seohyeon on 2022/07/20.
//

import UIKit

class LastVowelViewController: UIViewController {

    
    @IBOutlet weak var finishExplanation: UILabel!
    @IBAction func goToMain(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func goToConsonant(_ sender: Any) {
        
    }
    
    var caption: String = "모음 학습을 마쳤습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishExplanation.text = caption
    }

}
