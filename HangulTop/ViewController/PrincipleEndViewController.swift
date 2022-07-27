//
//  PrincipleEndViewController.swift
//  HangulTop
//
//  Created by Seulki Lee on 2022/07/19.
//

import UIKit

class PrincipleEndViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = "Congratulations! You have finished the Principle of the Invention of Hangul." // 임시 메시지
    }
    
    // 메뉴로 돌아가는 코드
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "isPrinciple")
        self.dismiss(animated: false)
        self.navigationController?.popToRootViewController(animated: true)
        

//        메뉴로 돌아가는 코드, 다음 메뉴 열리는 코드 들어가야 함
//        _ = navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
}
