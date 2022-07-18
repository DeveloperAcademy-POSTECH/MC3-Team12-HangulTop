//
//  PrincipleViewController.swift
//  HangulTop
//
//  Created by Seulki Lee on 2022/07/18.
//

import UIKit

class PrincipleViewController: UIViewController {
    @IBOutlet weak var progressNum: UILabel!
    @IBOutlet weak var principleTitle: UILabel!
    @IBOutlet weak var principleSubtitle: UILabel!
    @IBOutlet weak var principleImage: UIImageView!
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    // 현재 버튼들 cornerRadius 전부 key path로 직접 숫자 집어넣었는데 이거 비율로 바꾸고 싶음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Principles"
        progressNum.text = "1/14"
        principleTitle.text = "한글은 누가 만들었을까?"
        explanation.text = "한글은 한국어의 공식문자이다.\n1443년 조선의 왕 세종이 한국어를 표기하기 위해 ‘훈민정음'이란 문자를 창제했고, 20세기 초반부터는 한글이란 명칭으로 부른다."
        prevButton.isHidden = true
        nextButton.isHidden = true
        principleSubtitle.isHidden = true
    }
    
    @IBAction func firstButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
}
