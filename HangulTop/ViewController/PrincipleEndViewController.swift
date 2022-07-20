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
        self.dismiss(animated: false)
        
        /* 메뉴로 돌아가는 코드, 다음 메뉴 열리는 코드 들어가야 함
         
         If you want to go back to the previous view controller
         _ = navigationController?.popViewController(animated: true)
         
         If you want to go back to the root view controller
         _ = navigationController?.popToRootViewController(animated: true)
         
         이 두 경우 중 메뉴뷰에서 원리뷰로 넘어오는 코드가 어떻게 구현된지 몰라서 + 아직 머지되지 않았기 때문에 우선은 생략하고 넘어감
         */
    }
}
