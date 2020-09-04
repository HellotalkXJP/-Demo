//
//  ViewController2.swift
//  测试动画
//
//  Created by Mac on 2020/9/4.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var timer: Timer = Timer.init()//定时器
    var moveLayer: CALayer = CALayer.init()//动画layer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func showRain(){
        //创建画布
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "x")
        imageV.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        //这里把这句消除动画有问题
        self.moveLayer = CALayer.init()
        self.moveLayer.bounds = (imageV.frame)
        self.moveLayer.anchorPoint = CGPoint(x: 0, y: 0)
        //此处y值需比layer的height大
        self.moveLayer.position = CGPoint(x: 0, y: -40)
        self.moveLayer.contents = imageV.image!.cgImage
        
        self.view.layer.addSublayer(self.moveLayer)
        //画布动画
        addAnimation()
    }
    
    //给画布添加动画
    func addAnimation() {
        //此处keyPath为CALayer的属性
        let  moveAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath:"position")
        //动画路线，一个数组里有多个轨迹点
        moveAnimation.values = [NSValue.init(cgPoint: CGPoint(x: CGFloat(arc4random_uniform(320)), y: 64)), NSValue.init(cgPoint: CGPoint(x: CGFloat(arc4random_uniform(320)), y: 1000))]
        
        //动画间隔
        moveAnimation.duration = 5
        //重复次数
        moveAnimation.repeatCount = 1
        //动画的速度
//        moveAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        moveAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        self.moveLayer.add(moveAnimation, forKey: "move")
        
//        self.moveLayer.add(moveAnimation, forKey: "rotationAnimation")
    }

    @IBAction func startClick(_ sender: Any) {
        //防止timer重复添加
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showRain), userInfo: "", repeats: true)
    }
    
    @IBAction func stopClick(_ sender: Any) {
        self.timer.invalidate()
        //停止所有layer的动画
        for item in self.view.layer.sublayers!{
            item.removeAllAnimations()
        }
    }
}
