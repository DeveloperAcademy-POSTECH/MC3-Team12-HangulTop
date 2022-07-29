//
//  InformationModalViewController.swift
//  HangulTop
//
//  Created by Seulki Lee on 2022/07/29.
//

import UIKit

class InformationModalViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var principleImage: UIImageView!
    
    var informationModal = InformationModalModel()
    var pageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetController = self.presentationController as? UISheetPresentationController {
                sheetController.detents = [.medium(), .large()]
            }
        
        titleLabel.text = informationModal.titleArray[pageCount]
        infoLabel.text = informationModal.infoArray[pageCount]
        // ImageView
    }
    
}
