//
//  InfoTestVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 12.05.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InfoTestVC: UIViewController {

    @IBOutlet var textCond: UITextView?
    @IBOutlet weak var bannerViewInfoTest: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // real UnitID 1:   ca-app-pub-2440183521770590/9348176488
        // real UnitID 2:   ca-app-pub-2440183521770590/9156604793
        // real UnitID 3:   ca-app-pub-2440183521770590/2591196444
        // test UnitID: ca-app-pub-3940256099942544/2934735716
        
        bannerViewInfoTest.adUnitID = "ca-app-pub-2440183521770590/9156604793"
        bannerViewInfoTest.rootViewController = self
        bannerViewInfoTest.load(GADRequest())
        
        textCond?.text = "\n\nEinbürgerungstest là kỳ thi trắc nghiệm xung quanh các chủ đề Xã hội, Lịch sử, Chính trị và con người Đức, do Sở di cư và tỵ nạn liên bang (BAMF) biên soạn.\n\nThông qua việc thi đậu kỳ thi này sẽ chứng mình được sự hòa nhập cửa người nước ngoài vào Xã hội Đức để xin giấy phép cư trú vô thời hạn (unbefristete Aufenthalterlaubnis) , cũng như là một điều kiện tiên quyết để nhập quốc tịch Đức.\n\nBài thi gồm 33 câu hỏi diễn ra trong 60 phút, trả lời đúng 17 câu trở lên được coi là đạt."
      
    }
    


}
