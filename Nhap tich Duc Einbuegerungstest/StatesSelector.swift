//
//  StatesSelector.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 11.05.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit

class StatesSelector: UIViewController {

    var unit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func stateTap(_ sender: Any) {
        unit = (sender as AnyObject).tag
        self.performSegue(withIdentifier: "StateSelectorToStatesQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "StateSelectorToStatesQuestion"){
            let sceneUnitSlectorVC = segue.destination as! StatesQuestionVC
            sceneUnitSlectorVC.unitSelected = unit
        }
    }
    

}
