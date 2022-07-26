//
//  StudyMenuViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class StudyMenuViewController: UIViewController {
    var indexCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toVowel(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.infos.indexCount = 0
    }
    
    @IBAction func toConsonant(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.infos.indexCount = 1
    }
    
    @IBAction func toBatchim(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.infos.indexCount = 2
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let viewController = segue.destination as? SyllableStartViewController {
//            viewController.indexCount = self.indexCount
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
