//
//  SyllableStartViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class SyllableStartViewController: UIViewController{
    let captionArray = ["There are a total of 21 vowels, and it consists of 10 basic vowels and 11 complex vowels that combine the basic vowels.", "There are a total of 19 consonants, consisting of 14 basic consonants and 5 compound consonants (ㄲ, ㄸ, ㅃ, ㅆ, ㅆ).", "Batchim means another consonant that comes after a consonant vowel combination. 16 single batchim and 11 double batchim are used as bacthim letters, but in actual pronunciation, only the 7 consonant sounds of ‘ㄱ,ㄴ,ㄷ,ㄹ,ㅁ,ㅂ,ㅇ'are pronounced."]
    let imageArray = ["vowel", "consonant", "batchim"]
    let extraCaptionArray = ["Since vowels are not used alone, here the first unsound consonant 'ㅇ' will be used as a symbol to indicate a space in front of the vowel.", "A compound vowel is a form of writing the basic consonants ㄱ, ㄷ, ㅂ, ㅅ, ㅈ twice.", "These 7 consonants are most often used as batchim, and double batchim is rarely used, so don't worry!"]
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
