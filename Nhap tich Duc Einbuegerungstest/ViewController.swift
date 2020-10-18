//
//  ViewController.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 20.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit

class ViewController: UIViewController{
    
    @IBOutlet weak var btnPP: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnGQ: UIButton!
    @IBOutlet weak var btnTrial: UIButton!
    @IBOutlet weak var btnStates: UIButton!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton(btn: btnGQ)
        setButton(btn: btnInfo)
        setButton(btn: btnPP)
        setButton(btn: btnTrial)
        setButton(btn: btnStates)
        
        // real UnitID 1:   ca-app-pub-2440183521770590/9348176488
        // real UnitID 2:   ca-app-pub-2440183521770590/9156604793
        // real UnitID 3:   ca-app-pub-2440183521770590/2591196444
        // test UnitID:     ca-app-pub-3940256099942544/2934735716
        
        bannerView.adUnitID = "ca-app-pub-2440183521770590/9348176488"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
   
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    
    func setButton(btn: UIButton) {
        btn.titleLabel!.font = UIFont(name: "Arial Hebrew Bold", size: 30)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 9
        btn.backgroundColor = UIColor.lightGray
        btn.alpha = CGFloat.init(0.9)
    }
    
    
    //--------------- Back to Main ----------------------
    @IBAction func unwindToMain(segue:UIStoryboardSegue) { }
    
    @IBAction func linktoPP(_ sender: Any) {
        if let url = URL(string: "https://quangbruder.wixsite.com/home/post/privacy-policy-for-nhap-tich-duc-einbuergerungstest") {
            //if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            //}
        }
        
    }
    
    //-----Play trial version ---------------------
    @IBAction func trialTap(_ sender: Any) {
        self.performSegue(withIdentifier: "TrialtoGeneralQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TrialtoGeneralQuestion"){
        let sceneUnitSlectorVC = segue.destination as! GeneralQuestionVC
        sceneUnitSlectorVC.unitSelected = 1
        }
    }
    
    //----- Play general or states questions -------------
    @IBAction func GQTap(_ sender: Any) {
        //self.performSegue(withIdentifier: "GQTap", sender: self)
    }
    
    @IBAction func SQTap(_ sender: Any) {
        self.performSegue(withIdentifier: "SQTap", sender: self)
    }

}

