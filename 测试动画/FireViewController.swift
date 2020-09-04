//
//  FireViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class FireViewController: UIViewController {

    var fireLayer = CAEmitterLayer()
    var smokeLayer = CAEmitterLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmitter()
    }
    

    func setupEmitter() {
        view.layer.addSublayer(smokeLayer)
        view.layer.addSublayer(fireLayer)
        
        
        // 1. 设置CAEmitterLayer
        // 烟雾
        smokeLayer.renderMode = .additive
        smokeLayer.emitterMode = .points
        smokeLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: view.bounds.size.height - 64)
        
        // 火花
        fireLayer.emitterShape = .line
        fireLayer.emitterMode = .outline
        fireLayer.renderMode = .additive
        fireLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: view.bounds.size.height - 64)
        fireLayer.emitterSize = CGSize(width: 100, height: 0)
        
        // 2. 配置CAEmitterCell
        // 火花
        let fireCell = CAEmitterCell()
        fireCell.name = "fireCell"
        fireCell.contents = UIImage(named: "fire_white")?.cgImage
        fireCell.birthRate = 450.0
        fireCell.scaleSpeed = 0.5
        fireCell.lifetime = 0.9
        fireCell.lifetimeRange = 0.315
        
        fireCell.velocity = -80.0
        fireCell.velocityRange = 30.0
        fireCell.yAcceleration = -200.0;// 向上
        
        fireCell.emissionLongitude = CGFloat(Double.pi)
        fireCell.emissionRange = 1.1
        
        fireCell.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.1).cgColor
        
        // 烟雾
        let smokeCell = CAEmitterCell()
        smokeCell.name = "smokeCell"
        smokeCell.contents = UIImage(named: "smoke_white")?.cgImage
        
        smokeCell.birthRate = 11
        smokeCell.scale = 0.1
        smokeCell.scaleSpeed = 0.7
        smokeCell.lifetime = 3.6
        
        smokeCell.velocity = -40.0
        smokeCell.velocityRange = 20.0
        smokeCell.yAcceleration = -160.0 // 向上
        
        smokeCell.emissionLongitude = -CGFloat(Double.pi / 2)  // 向上
        smokeCell.emissionRange = CGFloat(Double.pi / 4) // 围绕x轴上方向成90度
        
        smokeCell.spin = 1.0
        smokeCell.spinRange = 6.0
        
        smokeCell.alphaSpeed = -0.12
        smokeCell.color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.27).cgColor
        
        // 3. 添加到图层
        smokeLayer.emitterCells = [smokeCell]
        fireLayer.emitterCells = [fireCell]
    }
    
    func setFireAndSmokeHight(_ event: UIEvent) {
        if let alltouches = event.allTouches, let touch = alltouches.first {
            // 获取手指所在点
            let point = touch.location(in: self.view)
            
            // 计算比例
            let distanceToBottom = self.view.bounds.size.height - point.y
            let per = distanceToBottom / self.view.bounds.size.height
                        
            // 设置数量
            setFireAndSmokeCount(per)
        }
    }
    
    /**
    * 设置火花的数量
    * ration: 比例系数 0 到 1之间
    */
    func setFireAndSmokeCount(_ ratio: CGFloat) {
        // 产生数量
        fireLayer.setValue(ratio * 500.0, forKeyPath: "emitterCells.fireCell.birthRate")
        
        // 生命周期
        fireLayer.setValue(ratio, forKeyPath: "emitterCells.fireCell.lifetime")
        // 生命周期变化范围
        fireLayer.setValue(ratio * 0.35, forKeyPath: "emitterCells.fireCell.lifetimeRange")
        // 发射源大小
        fireLayer.setValue(ratio * 50.0, forKeyPath: "emitterSize")
        
        smokeLayer.setValue(ratio * 4.0, forKeyPath: "emitterCells.smokeCell.lifetime")
        smokeLayer.setValue(UIColor(red: 1, green: 1, blue: 1, alpha: ratio * 0.3).cgColor, forKeyPath: "emitterCells.smokeCell.color")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let event = event {
            setFireAndSmokeHight(event)
        }
    }
}
