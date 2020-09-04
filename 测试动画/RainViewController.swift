//
//  RainViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class RainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var rainLayer: CAEmitterLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmitter()
    }
    
    func setupEmitter() {
        imageView.layer.addSublayer(rainLayer)
        
        // 1. 设置CAEmitterLayer
        // 发射源的形状是一条线
        rainLayer.emitterShape = .line
        rainLayer.emitterMode = .surface
        rainLayer.emitterSize = view.frame.size
        rainLayer.emitterPosition = CGPoint(x: self.view.bounds.size.width * 0.5, y: 64)
        
        // 2. 配置cell
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "rain_white")?.cgImage
        rainCell.birthRate = 25.0
        rainCell.lifetime = 20.0
        rainCell.speed = 10.0
        
        rainCell.velocity = 10.0
        rainCell.velocityRange = 10.0
        rainCell.yAcceleration = 1000.0
        
        rainCell.scale = 0.1
        rainCell.scaleRange = 0.0
        
        // 3.添加到图层上
        rainLayer.emitterCells = [rainCell]
    }
    
    @IBAction func rainBtnClick(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = !sender.isSelected
            
            // 停止下雨
            rainLayer.setValue(0.0, forKeyPath: "birthRate")
        } else {
            sender.isSelected = !sender.isSelected
            
            // 开始下雨
            rainLayer.setValue(1.0, forKeyPath: "birthRate")
        }
    }
    

    @IBAction func changeBtnClick(_ sender: UIButton) {
        let rate: Float = 1.0
        let scale: Float = 0.05
        
        if sender.tag == 100 {
            print("下大了 rainLayer.birthRate:\(rainLayer.birthRate)")
            if rainLayer.birthRate < 30 {
                let birthRateValue = rainLayer.birthRate + rate
                rainLayer.setValue(birthRateValue, forKeyPath: "birthRate")
                
                let scaleValue = rainLayer.scale + scale
                rainLayer.setValue(scaleValue, forKeyPath: "scale")
            }
        } else if sender.tag == 200 {
            print("变小了 rainLayer.birthRate:\(rainLayer.birthRate)")
            if rainLayer.birthRate > 1 {
                let birthRateValue = rainLayer.birthRate - rate
                rainLayer.setValue(birthRateValue, forKeyPath: "birthRate")
                
                let scaleValue = rainLayer.scale - scale
                rainLayer.setValue(scaleValue, forKeyPath: "scale")
            }
        }
    }
}
