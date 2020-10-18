//
//  InfoCondVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 12.05.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InfoCondVC: UIViewController {
    @IBOutlet var textCond: UITextView?
    @IBOutlet weak var bannerViewInfoCond: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // real UnitID 1:   ca-app-pub-2440183521770590/9348176488
            // real UnitID 2:   ca-app-pub-2440183521770590/9156604793
            // real UnitID 3:   ca-app-pub-2440183521770590/2591196444
            // test UnitID: ca-app-pub-3940256099942544/2934735716
        
            bannerViewInfoCond.adUnitID = "ca-app-pub-2440183521770590/9156604793"
            bannerViewInfoCond.rootViewController = self
            bannerViewInfoCond.load(GADRequest())
        
        textCond?.text = "1. Cư trú hợp pháp liên tục 8 năm ở Đức.\n\n2. Thừa nhận Hiến pháp CHLB Đức. \n\n3. Sở hữu giấy phép thường trú (Niederlassungserlaubnis) của Đức, EU hoặc giấy phép tạm trú (Aufenthaltserlaubnis) không thuộc các điều sau §§ 16, 17, 17a, 20, 22, 23 Absatz 1, §§ 23a, 24 und 25 Abs. 3 bis 5 Aufenthaltsgesetzes.\n\n4. Đảm bảo tài chính cho bản thân và người thân phụ thuộc để ko nhận trợ cấp xã hội.\n\n5. Không phạm tội. \n\n6. Từ bỏ quốc tịch hiện tại. \n\n7. Có đủ kiến thức tiếng Đức và thi đậu kỳ kiểm tra nhập quốc tịc Đức (Einbürgerungstest.)"
        
    }
    


}
