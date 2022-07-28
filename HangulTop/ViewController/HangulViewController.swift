//
//  HangulViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/28.
//

import UIKit

class HangulViewController: UIViewController {

    @IBOutlet weak var mainLetter: UILabel!
    var hangul: String = "가"
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLetter.text = hangul
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewSelect(_ sender: Any) {
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
