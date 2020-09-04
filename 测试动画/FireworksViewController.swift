//
//  FireworksViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class FireworksViewController: UIViewController {

    var fireworksLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupEmitter()
    }
    

    func setupEmitter() {
        view.layer.addSublayer(fireworksLayer)
        
        // 1. 设置CAEmitterLayer
        fireworksLayer.emitterShape = .line
        fireworksLayer.emitterMode = .outline
        fireworksLayer.renderMode = .additive
        // 位置在底部中间
        fireworksLayer.emitterPosition = CGPoint(x: view.bounds.size.width * 0.5, y: view.bounds.size.height)
        fireworksLayer.emitterSize = CGSize(width: view.bounds.size.width * 0.1, height: 0)
        
        // 2. 配置CAEmitterCell
        // 发射cell
        let shootCell = CAEmitterCell()
        shootCell.name = "shootCell"
        shootCell.birthRate = 1.0
        // 上一个销毁了下一个再发出来
        shootCell.lifetime = 1.02
        
        shootCell.velocity = 600.0
        shootCell.velocityRange = 100.0
        // 模拟重力影响
        shootCell.yAcceleration = 75.0
        
        shootCell.emissionRange = CGFloat(Double.pi / 4)
        
        shootCell.scale = 0.05
        shootCell.color = UIColor.red.cgColor
        shootCell.greenRange = 1.0
        shootCell.redRange = 1.0
        shootCell.blueRange = 1.0
        shootCell.contents = UIImage(named: "shoot_white")?.cgImage
        
        // 自转360度
        shootCell.spinRange = CGFloat(Double.pi)
        
        // 爆炸cell
        let explodeCell = CAEmitterCell()
        explodeCell.name = "explodeCell";
        
        explodeCell.birthRate = 1.0
        explodeCell.lifetime = 0.5
        explodeCell.velocity = 0.0
        explodeCell.scale = 2.5
        // 爆炸的时候变化颜色
        explodeCell.redSpeed = -1.5
        // 爆炸的时候变化颜色
        explodeCell.blueRange = 1.5
        // 爆炸的时候变化颜色
        explodeCell.greenRange = 1.0
        
        // 火花cell
        let sparkCell = CAEmitterCell()
        sparkCell.name = "sparkCell"
        
        sparkCell.birthRate = 400.0
        sparkCell.lifetime = 3.0
        sparkCell.velocity = 125.0
        // 模拟重力影响
        sparkCell.yAcceleration = 75.0
        // 360度
        sparkCell.emissionRange = CGFloat(Double.pi * 2)
        
        sparkCell.scale = 1.20
        sparkCell.contents = UIImage(named: "star_white_stroke")?.cgImage
        sparkCell.redSpeed = 0.4
        sparkCell.greenSpeed = -0.1
        sparkCell.blueSpeed = -0.1
        sparkCell.alphaSpeed = -0.25
        
        // 自转360度
        sparkCell.spin = CGFloat(Double.pi * 2)
        
        //添加动画
        fireworksLayer.emitterCells = [shootCell]
        shootCell.emitterCells = [explodeCell]
        explodeCell.emitterCells = [sparkCell]
    }
}
