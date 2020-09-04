//
//  ViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/1.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "测试动画"
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func jumpAClick(_ sender: UIButton) {
        let vc = ViewController2()
        vc.title = sender.titleLabel?.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func jumpClick(_ sender: UIButton) {
        let vc = ViewController3()
        vc.title = sender.titleLabel?.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
