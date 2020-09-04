//
//  HeartViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class HeartViewController: UIViewController {

    var heartLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmitter()
    }
    
    func setupEmitter() {
        view.layer.addSublayer(heartLayer)
        
        // 1. 设置CAEmitterLayer
        // 发射源的形状是一个矩形
        heartLayer.emitterShape = .rectangle
        heartLayer.emitterMode = .volume
        heartLayer.renderMode = .additive
        heartLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: view.bounds.size.height - 64)
        heartLayer.emitterSize = CGSize(width: 100, height: 30)
        
        // 2. 配置CAEmitterCell
        let heartCell = CAEmitterCell()
        heartCell.contents = UIImage(named: "love_red")?.cgImage
        heartCell.color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 0.5).cgColor
        heartCell.redRange = 0.3
        heartCell.blueRange = 0.3
        heartCell.alphaRange = -0.05
        
        heartCell.name = "heartCell"
        heartCell.birthRate = 0.0
        heartCell.lifetime = 10.0
        heartCell.velocity = -120.0
        heartCell.velocityRange = 60.0
        heartCell.yAcceleration = 20.0
        
        heartCell.emissionLongitude = CGFloat(Double.pi / 2)
        heartCell.emissionRange = CGFloat(Double.pi / 2 * 0.55 )
        
        heartCell.scale = 0.5
        heartCell.scaleRange = 0.5
        // 自转
        heartCell.spinRange = CGFloat(Double.pi * 2.0)
        
        // 添加到图层
        heartLayer.emitterCells = [heartCell]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let anim = CABasicAnimation(keyPath: "emitterCells.heartCell.birthRate")
        anim.fromValue = 150.0
        anim.toValue = 0.0
        anim.duration = 5.0
        anim.timingFunction = CAMediaTimingFunction(name: .linear)
        heartLayer.add(anim, forKey: "heartAnim")
    }
}
