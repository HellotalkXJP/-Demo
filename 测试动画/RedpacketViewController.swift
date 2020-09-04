//
//  RedpacketViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class RedpacketViewController: UIViewController {

    var redpacketLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupEmitter()
    }
    
    
    func setupEmitter() {
        view.layer.addSublayer(redpacketLayer)
        
        // 1. 设置CAEmitterLayer
        // 发射源的形状是一条线
        redpacketLayer.emitterShape = .line
        // 发射模式
        redpacketLayer.emitterMode = .surface
        // 发射源的size
        redpacketLayer.emitterSize = view.frame.size
        // 发射源的位置
        redpacketLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: 0)
        // 每秒产生的粒子数量的系数
        redpacketLayer.birthRate = 0.0
        
        // 2. 配置cell
        let redCell = CAEmitterCell()
        // 粒子的内容
        redCell.contents = UIImage(named: "red_paceket")?.cgImage
        // 每秒产生的粒子数量
        redCell.birthRate = 10.0
        // 粒子的生命周期
        redCell.lifetime = 20.0
        // 粒子的速度
        redCell.velocity = 8.0
        // 粒子再y方向的加速的
        redCell.yAcceleration = 300
        // 粒子的缩放比例
        redCell.scale = 0.5
        
//        redCell.emissionRange = CGFloat(Double.pi)
        
//        redCell.emissionLongitude = CGFloat(Double.pi / 2)
//        redCell.emissionRange = CGFloat(Double.pi / 4)
        // 3. 粒子添加到CAEmitterLayer上
        redpacketLayer.emitterCells = [redCell]
    }
    
    @IBAction func startClick(_ sender: Any) {
        redpacketLayer.setValue(1.0, forKeyPath: "birthRate")
    }
    
    
    @IBAction func stopClick(_ sender: Any) {
        redpacketLayer.setValue(0.0, forKeyPath: "birthRate")
    }
}
