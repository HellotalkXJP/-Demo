//
//  ColorfulballViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ColorfulballViewController: UIViewController {
    var colorLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupEmitter()
    }
    
    func setupEmitter() {
        view.layer.addSublayer(colorLayer)
        
        // 1. 设置CAEmitterLayer
        // 发射源的形状就是一个点
        colorLayer.emitterShape = .point
        colorLayer.emitterMode = .points
        colorLayer.emitterSize = view.frame.size
        colorLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: 0)
        
        // 2. 配置CAEmitterCell
        let colorCell = CAEmitterCell()
        colorCell.contents = UIImage(named: "circle_white")?.cgImage
        colorCell.color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0).cgColor
        colorCell.redRange = 1.0
        colorCell.greenRange = 1.0
        colorCell.blueRange = 1.0
        colorCell.alphaRange = 0.8
        colorCell.alphaSpeed = -0.1
        
        colorCell.name = "colorCell"
        colorCell.birthRate = 20.0
        colorCell.lifetime = 10.0
        colorCell.velocity = 40.0
        colorCell.velocityRange = 100.0
        colorCell.yAcceleration = 15.0
        colorCell.emissionLongitude = CGFloat(Double.pi / 2)
        colorCell.emissionRange = CGFloat(Double.pi / 4)
        colorCell.scale = 0.2
        colorCell.scaleRange = 0.1
        colorCell.scaleSpeed = 0.02
        
        // 添加到图层
        colorLayer.emitterCells = [colorCell]
    }
    
    /**
    * 获取手指所在点
    */
    func locationFromTouchEvent(_ event: UIEvent) -> CGPoint {
        if let allTouches = event.allTouches, let touch = allTouches.first {
            return touch.location(in: self.view)
        }
        
        return CGPoint(x: 0, y: 0)
    }
    
    /**
    * 移动发射源到某个点上
    */
    func setBallInPsition(_ point: CGPoint) {
        let anim = CABasicAnimation(keyPath: "emitterCells.colorBallCell.scale")
        anim.fromValue = 0.2
        anim.toValue = 0.5
        anim.duration = 1.0
        anim.timingFunction = CAMediaTimingFunction.init(name: .linear)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.add(anim, forKey: nil)
        colorLayer.setValue(point, forKey: "emitterPosition")
        CATransaction.commit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let event = event {
            let point = locationFromTouchEvent(event)
            setBallInPsition(point)
        }
    }
}
