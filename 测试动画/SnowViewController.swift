//
//  SnowViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SnowViewController: UIViewController {

    var snowLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        
        // Do any additional setup after loading the view.
        setupEmitter()
    }
    
    func setupEmitter() {
        view.layer.addSublayer(snowLayer)
        
        // 1. 设置CAEmitterLayer
        // 发射源的形状是一条线
        snowLayer.emitterShape = .line
        snowLayer.emitterMode = .surface
        snowLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: 64)
        snowLayer.emitterSize = view.frame.size
        snowLayer.birthRate = 0.0
            
        // 2. 配置cell
        let snowCell = CAEmitterCell()
        snowCell.contents = UIImage(named: "snow_white")?.cgImage
        snowCell.birthRate = 1.0
        snowCell.lifetime = 200.0
        snowCell.speed = 10.0
        snowCell.velocity = 2.0
        snowCell.velocityRange = 10.0
        snowCell.yAcceleration = 10.0
        snowCell.scale = 0.2
        snowCell.scaleRange = 0.3
        // 垂直向下
        snowCell.emissionLongitude = CGFloat(Double.pi / 2)
        // 左右45°
        snowCell.emissionRange = CGFloat(Double.pi / 4)
        
        // 3.添加到图层上
        snowLayer.emitterCells = [snowCell]
    }
    
    @IBAction func startClick(_ sender: Any) {
        snowLayer.setValue(1.0, forKeyPath: "birthRate")
    }
    
    @IBAction func stopClick(_ sender: Any) {
        snowLayer.setValue(0.0, forKeyPath: "birthRate")
    }
}
