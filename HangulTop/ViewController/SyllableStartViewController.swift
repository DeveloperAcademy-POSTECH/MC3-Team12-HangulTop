//
//  SyllableStartViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class SyllableStartViewController: UIViewController{
    let explanation = ["모음은 총 21개로, 기본 모음 10개와 기본 모음을 합친 형태인 복합 모음 11개로 구성되어 있습니다.", "자음은 총 19개로, 기본자음 14개와 복합자음(ㄲ,ㄸ,ㅃ,ㅆ,ㅉ) 5개로 구성되어 있다.", "자음 모음 결합 밑에 오는 또 다른 자음을 뜻 한다.\n받침 글자로는 홑받침 16개와 겹받침 11개가 사용되지만 실제 발음에서는 'ㄱ,ㄴ,ㄷ,ㄹ,ㅁ,ㅇ'의 7개 자음의 소리로만 발음한다.\n* 7개의 자음이 받침으로 가장 많이 쓰이고, 겹받침은 매우 드물게 쓰인다"]
    var indexCount: Int?
    @IBOutlet weak var caption: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        indexCount = appDelegate?.infos.indexCount
        caption.text = explanation[indexCount ?? 0]
        // Do any additional setup after loading the view.
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
