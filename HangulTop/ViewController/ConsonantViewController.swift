//
//  ConsonantViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/18.
//

import UIKit

class ConsonantViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var pageNum = 0
    let consonantArray = [["ㄱ","ㅋ","ㄲ"], ["ㄴ","ㄷ","ㅌ","ㄹ","ㄸ"], ["ㅁ", "ㅂ","ㅍ","ㅃ"], ["ㅅ","ㅈ","ㅊ","ㅉ","ㅆ"], ["ㅇ","ㅎ"]]
    let vowelArray = ["ㅡ", "ㅣ", "ㅏ", "ㅓ", "ㅗ", "ㅜ", "ㅑ", "ㅕ", "ㅛ", "ㅠ", "ㅐ", "ㅔ", "ㅒ", "ㅖ", "ㅘ", "ㅚ", "ㅙ", "ㅝ", "ㅟ", "ㅞ", "ㅢ"]
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBAction func prevPage(_ sender: Any) {
        if pageNum > 0 {
            pageNum -= 1
            setLayout(ConsonantViewController(), customView, btnList: consonantArray[pageNum])
            setPageControl()
        }
    }
    @IBAction func nextPage(_ sender: Any) {
        if pageNum < consonantArray.count - 1 {
            pageNum += 1
            setLayout(ConsonantViewController(), customView, btnList: consonantArray[pageNum])
            setPageControl()
        }
        if pageNum == consonantArray.count - 1 {
            performSegue(withIdentifier: "finish_seg", sender: sender)
        }
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
        print(sender.titleLabel?.text ?? "error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout(ConsonantViewController(), customView, btnList: consonantArray[pageNum])
    }
    
    func setPageControl() {
        if pageNum == 0 {
            prevBtn.isHidden = true
        } else {
            prevBtn.isHidden = false
        }
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

