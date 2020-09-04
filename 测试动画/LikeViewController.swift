//
//  LikeViewController.swift
//  测试动画
//
//  Created by Mac on 2020/9/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let likeBtn = LikeButton(frame: CGRect(x: view.bounds.size.width * 0.5, y: view.bounds.size.height * 0.5, width: 30, height: 130))
        likeBtn.setImage(UIImage(named: "dislike"), for: .normal)
        likeBtn.setImage(UIImage(named: "liek_orange"), for: .selected)
        likeBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view.addSubview(likeBtn)
    }

    @objc func btnClick(_ sender: UIButton) {
        if !sender.isSelected {
            // 点赞
            sender.isSelected = !sender.isSelected
            
            print("点赞了")
        } else {
            sender.isSelected = !sender.isSelected
            
            print("取消点赞了")
        }
    }
}

class LikeButton: UIButton {
    var explosionLayer = CAEmitterLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupExplosion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupExplosion() {
        layer.addSublayer(explosionLayer)
        
        // 1. 设置CAEmitterLayer
        explosionLayer.emitterShape = .circle
        explosionLayer.emitterMode = .outline
        explosionLayer.renderMode = .oldestFirst
        explosionLayer.emitterSize = CGSize(width: self.bounds.size.width + 40, height: self.bounds.size.height + 40)
        
        // 2. 配置CAEmitterCell
        let explosionCell = CAEmitterCell()
        explosionCell.name = "explosionCell"
        explosionCell.alphaSpeed = -1.0
        explosionCell.alphaRange = 0.10
        explosionCell.lifetime = 1
        explosionCell.lifetimeRange = 0.1
        explosionCell.velocity = 40.0
        explosionCell.velocityRange = 10.0
        explosionCell.scale = 0.08
        explosionCell.scaleRange = 0.02
        explosionCell.contents = UIImage(named: "spark_red")?.cgImage
        
        // 3. 添加到图层
        explosionLayer.emitterCells = [explosionCell]
    }
    
    override func layoutSubviews() {
        self.explosionLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        super.layoutSubviews()
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                let anim = CAKeyframeAnimation()
                anim.values = [1.5, 2.0, 0.8, 1.0]
                anim.duration = 0.5
                anim.calculationMode = .cubic
                layer.add(anim, forKey: nil)
                
                // 让放大动画先执行完毕 再执行爆炸动画
                self.perform(#selector(startAnimation), with: nil, afterDelay: 0.15)
            } else {
                // 从点击状态normal状态 无动画效果 如果点赞之后马上取消 那么也立马停止动画
                stopAnimation()
            }
        }
    }
    
    @objc func startAnimation() {
        // 用KVC设置颗粒个数
        explosionLayer.setValue(1000, forKeyPath: "emitterCells.explosionCell.birthRate")
        // 开始动画
        explosionLayer.beginTime = CACurrentMediaTime()
        
        self.perform(#selector(stopAnimation), with: nil, afterDelay: 0.15)
    }
    
    @objc func stopAnimation() {
        // 用KVC设置颗粒个数
        explosionLayer.setValue(0, forKeyPath: "emitterCells.explosionCell.birthRate")
        explosionLayer.removeAllAnimations()
    }
}
