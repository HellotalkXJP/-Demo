//
//  ViewController2.swift
//  测试动画
//
//  Created by Mac on 2020/9/1.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func BtnClick(_ sender: UIButton) {
        var vc: UIViewController = UIViewController()
        switch sender.tag {
        case 100:
            vc = RainViewController()
            break
        case 200:
            vc = RedpacketViewController()
            break
        case 300:
            vc = SnowViewController()
            break
        case 400:
            vc = ColorfulballViewController()
            break
        case 500:
            vc = HeartViewController()
            break
        case 600:
            vc = FireViewController()
            break
        case 700:
            vc = FireworksViewController()
            break
        case 800:
            vc = LikeViewController()
            break
        default:
            vc = UIViewController()
            break
            
        }
        
        vc.title = sender.titleLabel?.text
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
