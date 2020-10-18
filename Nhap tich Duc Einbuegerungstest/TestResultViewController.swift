//
//  TestResultViewController.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 23.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit

class TestResultViewController: UIViewController {

    @IBOutlet weak var FailorPassImg: UIImageView!
    @IBOutlet weak var passportImage: UIImageView!
    var isPass = false
    var textFromGeneralQuestion = "123"
    @IBOutlet weak var resultofTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultofTest.text = textFromGeneralQuestion
        
        if(!isPass){
            passportImage.image = nil
            FailorPassImg.image = UIImage.init(named: "durchfallen")
        }
    }
    
}
