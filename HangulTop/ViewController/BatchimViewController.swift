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
    
    
    var batchimModel = BatchimModel() //초기화, 인스턴스?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    
//    @IBAction func didTapButton1(_ sender: UIButton) {
//        resultLabel.text = button1.title(for: .normal)
//    }
//    버튼을 눌렀을 때 resultLabel이 바뀌었으면 하는데 아무일도 일어나지 않음
    

    

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
    
    
    //설명 업데이트
    func updateUI() {
//        button1.title(for: .normal) = batchimModel.getLetters()
//        ㄴ버튼 타이틀이 업데이트 할 때 마다 바뀌었으면 좋겠다
        explanation.text = batchimModel.getInfo()
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
