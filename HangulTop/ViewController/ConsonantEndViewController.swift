//
//  ConsonantEndViewController.swift
//  HangulTop
//
//  Created by kimjimin on 2022/07/21.
//

import UIKit

struct Info {
    var indexCount: Int
}

class ConsonantEndViewController: UIViewController {
    var data: Int? = 0
    
    @IBOutlet weak var goToStudy: UIButton!
    
    @IBAction func goToMain(_ sender: Any) {
        //네비게이션 스택 중 원하는 지점으로 보내줌
        let controllers = self.navigationController?.viewControllers



        for vc in controllers! {
            if vc is StudyMenuViewController {
                        _ = self.navigationController?.popToViewController(vc as! StudyMenuViewController, animated: true)
            }
        }
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToStudy(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if(appDelegate?.infos.indexCount ?? 0 > 1){
            appDelegate?.infos.indexCount = 2
        }else{
            appDelegate?.infos.indexCount = (appDelegate?.infos.indexCount ?? 0) + 2
        }
        
        let controllers = self.navigationController?.viewControllers

        for vc in controllers! {
            if vc is SyllableStartViewController {
                        _ = self.navigationController?.popToViewController(vc as! SyllableStartViewController, animated: true)
            }
        }
//
//        self.navigationController?.popViewController(animated: true)
        
        //네비게이션 스택 중 원하는 지점으로 보내줌
//        let controllers = self.navigationController?.viewControllers
//
//
//
//        for vc in controllers! {
//            if vc is ConsonantViewController {
//                        _ = self.navigationController?.popToViewController(vc as! ConsonantViewController, animated: true)
//            }
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(data == 0){
            goToStudy.setTitle("자음 공부하러 가기", for: .normal)
        }else if(data == 1){
            goToStudy.setTitle("받침 공부하러 가기", for: .normal)
        }else{
            goToStudy.setTitle("공부 끝! 클릭 X", for: .normal)
        }
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
