//
//  SyllableStartViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class SyllableStartViewController: UIViewController{
    let captionArray = ["모음은 총 21개로, 기본 모음 10개와 기본 모음을 합친 형태인 복합 모음 11개로 구성되어 있습니다.", "자음은 총 19개로, 기본자음 14개와 복합자음\n(ㄲ,ㄸ,ㅃ,ㅆ,ㅉ) 5개로 구성되어 있습니다.", "받침은 자음 모음 결합 밑에 오는 또 다른 자음을 뜻 합니다. 받침 글자로는 홑받침 16개와 겹받침 11개가 사용되는데, 실제 발음에서는 ‘ㄱ,ㄴ,ㄷ,ㄹ,ㅁ,ㅂ,ㅇ'의 7개 자음의 소리로만 발음합니다."]
    let imageArray = ["vowel", "consonant", "batchim"]
    let extraCaptionArray = ["모음은 단독으로 쓰이지 않기 때문에, 여기선 첫번째로 올 때 음가가 없는 자음’ㅇ'을 모음 앞의 공백을 표시하는 기호로 쓸 것입니다.", "복합모음은 기본 자음 ㄱ, ㄷ, ㅂ, ㅅ, ㅈ를 두번씩 쓴 형태입니다.", "이 7개의 자음이 받침으로 가장 많이 쓰이고, 겹받침은 드물게 쓰이니 안심하세요!"]
    var indexCount: Int?
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var extraCaption: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        indexCount = appDelegate?.infos.indexCount
        caption.text = captionArray[indexCount ?? 0]
        extraCaption.text = extraCaptionArray[indexCount ?? 0]
        image.image = UIImage(named: imageArray[indexCount ?? 0])
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        indexCount = appDelegate?.infos.indexCount
        caption.text = captionArray[indexCount ?? 0]
        extraCaption.text = extraCaptionArray[indexCount ?? 0]
        image.image = UIImage(named: imageArray[indexCount ?? 0])
    }
}
