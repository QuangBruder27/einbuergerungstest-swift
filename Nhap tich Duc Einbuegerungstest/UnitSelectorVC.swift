//
//  UnitSelectorVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 26.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit

class UnitSelectorVC: UIViewController {

    var unit = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func unitTap(_ sender: Any) {
        unit = (sender as AnyObject).tag
          self.performSegue(withIdentifier: "UnitSelectortoGeneralQuestion", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "UnitSelectortoGeneralQuestion"){
            let sceneUnitSlectorVC = segue.destination as! GeneralQuestionVC
            sceneUnitSlectorVC.unitSelected = unit
        }
        if(segue.identifier == "UnitSelectortoGeneralQuestionWithImage"){
            let sceneUnitSlectorVC2 = segue.destination as! GeneralQuestionWithImgVC
            sceneUnitSlectorVC2.unitSelected = 11
        }
    }
}
