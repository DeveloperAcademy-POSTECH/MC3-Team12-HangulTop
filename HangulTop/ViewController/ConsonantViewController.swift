//
//  ConsonantViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/18.
//

import UIKit

class ConsonantViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    var pageNum = 0
    
    let consonantArray = [["ㄱ","ㅋ","ㄲ"], ["ㄴ","ㄷ","ㅌ","ㄹ","ㄸ"], ["ㅁ", "ㅂ","ㅍ","ㅃ"], ["ㅅ","ㅈ","ㅊ","ㅉ","ㅆ"], ["ㅇ","ㅎ"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout(ConsonantViewController(), customView, btnList: consonantArray[pageNum])
    }
}

// MARK: 전역함수
// FIXME: button action 필요 -> value 받아와서 mainletterview에 전달
// FIXME: button 개수가 7개 일때의 custom view 새로 생성
func setLayout(_ VC: UIViewController, _ customView: UIView, btnList: [String]) {
    let btnCnt = btnList.count
    let nibs = Bundle.main.loadNibNamed("ButtonSetView", owner: VC)
    guard let buttonSetView = nibs?.first as? ButtonSetView else {
        return
    }
    buttonSetView.frame = customView.bounds
    customView.addSubview(buttonSetView)
    
    if btnCnt == 1 {
        buttonSetView.button1.isHidden = true
        buttonSetView.button2.isHidden = true
        buttonSetView.button3.isHidden = true
        buttonSetView.button4.isHidden = true
        buttonSetView.button5.isHidden = true
        buttonSetView.button6.setTitle(btnList[0], for: .normal)
        buttonSetView.button7.isHidden = true
    }
    if btnCnt == 2 {
        buttonSetView.button1.isHidden = true
        buttonSetView.button2.setTitle(btnList[0], for: .normal)
        buttonSetView.button3.setTitle(btnList[1], for: .normal)
        buttonSetView.button4.isHidden = true
        buttonSetView.button5.isHidden = true
        buttonSetView.button6.isHidden = true
        buttonSetView.button7.isHidden = true
    }
    if btnCnt == 3 {
        buttonSetView.button1.isHidden = true
        buttonSetView.button2.isHidden = true
        buttonSetView.button3.isHidden = true
        buttonSetView.button4.isHidden = true
        buttonSetView.button5.setTitle(btnList[0], for: .normal)
        buttonSetView.button6.setTitle(btnList[1], for: .normal)
        buttonSetView.button7.setTitle(btnList[2], for: .normal)
    }
    if btnCnt == 4 {
        buttonSetView.button1.setTitle(btnList[0], for: .normal)
        buttonSetView.button2.setTitle(btnList[1], for: .normal)
        buttonSetView.button3.setTitle(btnList[2], for: .normal)
        buttonSetView.button4.setTitle(btnList[3], for: .normal)
        buttonSetView.button5.isHidden = true
        buttonSetView.button6.isHidden = true
        buttonSetView.button7.isHidden = true
    }
    if btnCnt == 5 {
        buttonSetView.button1.isHidden = true
        buttonSetView.button2.setTitle(btnList[0], for: .normal)
        buttonSetView.button3.setTitle(btnList[1], for: .normal)
        buttonSetView.button4.isHidden = true
        buttonSetView.button5.setTitle(btnList[2], for: .normal)
        buttonSetView.button6.setTitle(btnList[3], for: .normal)
        buttonSetView.button7.setTitle(btnList[4], for: .normal)
    }
}

