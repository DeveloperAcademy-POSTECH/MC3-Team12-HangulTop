//
//  TopMenuViewController.swift
//  HangulTop
//
//  Created by 이주화 on 2022/07/26.
//

import UIKit

class TopMenuViewController: UIViewController{
    
    
    var count: Int = 0
    @IBOutlet weak var quizCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.value(forKey: "solCount") == nil){
            count = 0
        }else{
            count = UserDefaults.standard.value(forKey: "solCount") as! Int
        }
        quizCount.text = "You have solved \(count * 10) problems in total."
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if(UserDefaults.standard.value(forKey: "solCount") == nil){
            count = 0
        }else{
            count = UserDefaults.standard.value(forKey: "solCount") as! Int
        }
        quizCount.text = "You have solved \(count * 10) problems in total."
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
