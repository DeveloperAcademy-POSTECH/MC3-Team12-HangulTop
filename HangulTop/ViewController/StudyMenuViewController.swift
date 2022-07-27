//
//  StudyMenuViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class StudyMenuViewController: UIViewController {
    var indexCount = 0
    @IBOutlet weak var vowelButton: UIButton!
    @IBOutlet weak var consonantButton: UIButton!
    @IBOutlet weak var batchimButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.value(forKey: "isPrinciple") == nil){
            vowelButton.isHidden = true
        }else{
            vowelButton.isHidden = false
        }
        if(UserDefaults.standard.value(forKey: "isVowel") == nil){
            consonantButton.isHidden = true
        }else{
            consonantButton.isHidden = false
        }
        if(UserDefaults.standard.value(forKey: "isConsonant") == nil){
            batchimButton.isHidden = true
        }else{
            batchimButton.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if(UserDefaults.standard.value(forKey: "isPrinciple") == nil){
            vowelButton.isHidden = true
        }else{
            vowelButton.isHidden = false
        }
        if(UserDefaults.standard.value(forKey: "isVowel") == nil){
            consonantButton.isHidden = true
        }else{
            consonantButton.isHidden = false
        }
        if(UserDefaults.standard.value(forKey: "isConsonant") == nil){
            batchimButton.isHidden = true
        }else{
            batchimButton.isHidden = false
        }
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
