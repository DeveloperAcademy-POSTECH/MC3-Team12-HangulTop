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
    @IBOutlet weak var principleImage: UIImageView?
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    // 현재 버튼들 cornerRadius 전부 key path로 직접 숫자 집어넣었는데 이거 비율로 바꾸고 싶음
    
    var principleModel = PrincipleModel() //초기화, 인스턴스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Principles"
        updateUI()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender == prevButton {
            // prev버튼들
            principleModel.prevView() // 이전 뷰로 돌아가기 위해 카운트 - 1
            updateUI()
        } else if principleModel.pageCount == 13 {
            // 마지막 페이지 즉 progressNum이 14인 경우에만 해당
            self.performSegue(withIdentifier: "goToEnd", sender: self)
            // 마지막 next버튼 누르면 완료 페이지로 넘어가게 하기 위한 코드
        } else {
            // 마지막 페이지 이전의 모든 next버튼들(첫 번째 페이지 포함)
            principleModel.nextView() // 다음 뷰로 넘어가기 위해 카운트 + 1
            updateUI()
        }
    }
    
    // UI 업데이트 해주는 함수
    func updateUI() {
        progressNum.text = "\(principleModel.pageCount + 1)/14"
        principleTitle.text = principleModel.getTitle()
        principleSubtitle.text = principleModel.getSubtitle()
        principleImage = principleModel.getImage()
        explanation.text = principleModel.getInfo()
        if principleModel.pageCount == 0 { // 첫 번째 뷰에서는 큰 next 버튼만 보이게 하고 작은 prev, next버튼은 숨김
            firstButton.isHidden = false
            prevButton.isHidden = true
            nextButton.isHidden = true
        } else { // 이외의 뷰에서는 큰 next 버튼 숨기고 작은 prev, next버튼은 보이게
            firstButton.isHidden = true
            nextButton.isHidden = false
            prevButton.isHidden = false
        }
    }
}
