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
    @IBOutlet weak var collectionView: UICollectionView!
    
    var principleModel = PrincipleModel() //초기화, 인스턴스
    var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Principles"
        collectionView.delegate = self
        collectionView.dataSource = self
        pageCount = 0
        updateUI()
    }
}

// 깔끔하게 정리하고 싶어서 본 클래스는 최소로 잡고 나머지 기능은 익스텐션으로 넣음
extension PrincipleViewController {
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender == prevButton {
            // prev버튼들
            pageCount -= 1
            updateUI()
        } else if pageCount == principleModel.contents.count - 1 {
            // 마지막 페이지 즉 pageCount가 13, progressNum이 14인 경우에만 해당
            self.performSegue(withIdentifier: "goToEnd", sender: self)
            // 마지막 next버튼 누르면 완료 페이지로 넘어가게 하기 위한 코드
        } else {
            // 마지막 페이지 이전의 모든 next버튼들(첫 번째 페이지 포함)
            pageCount += 1
            updateUI()
        }
    }
    
    // UI 업데이트 해주는 함수
    func updateUI() {
        progressNum.text = "\(pageCount + 1)/14"
        principleTitle.text = principleModel.getTitle(pageCount: pageCount)
        principleSubtitle.text = principleModel.getSubtitle(pageCount: pageCount)
        principleImage = principleModel.getImage(pageCount: pageCount)
        explanation.text = principleModel.getInfo(pageCount: pageCount)
        collectionView.reloadData()
        if pageCount == 0 { // 첫 번째 뷰에서는 큰 next 버튼만 보이게 하고 작은 prev, next버튼은 숨김
            firstButton.isHidden = false
            prevButton.isHidden = true
        } else {
            firstButton.isHidden = true
            prevButton.isHidden = false
            nextButton.isHidden = false
        }
    }
}

extension PrincipleViewController:
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return principleModel.contents[pageCount].letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "principleCell", for: indexPath) as! PrincipleCollectionViewCell
        
        cell.cellButton.setTitle("sibal", for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 10
    }
}
