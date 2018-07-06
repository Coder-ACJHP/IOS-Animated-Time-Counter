//
//  ViewController.swift
//  Animation Clock
//
//  Created by akademobi5 on 6.07.2018.
//  Copyright © 2018 Akademobi5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timeSec: Int = 0
    var timeMin: Int = 0
    var timeHour: Int = 0
    var timer = Timer()
    
    var endAngle = CGFloat.pi * 2
    
    var secsLayer = CAShapeLayer()
    var minLayer = CAShapeLayer()
    var hourLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    @IBOutlet weak var imageContainer: UIButton!
    @IBOutlet weak var secondContainer: UIButton!
    @IBOutlet weak var thirdContainer: UIButton!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let center = view.center
        let secPath = UIBezierPath(arcCenter: .zero, radius: 125, startAngle: 0.0, endAngle: endAngle, clockwise: true)
        let minPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0.0, endAngle: endAngle, clockwise: true)
        let hourPath = UIBezierPath(arcCenter: .zero, radius: 75, startAngle: 0.0, endAngle: endAngle, clockwise: true)
        
        animate(onView: view, layer: secsLayer, shapePath: secPath.cgPath, name: "sec")
        animate(onView: view, layer: minLayer, shapePath: minPath.cgPath, name: "min")
        animate(onView: view, layer: hourLayer, shapePath: hourPath.cgPath, name: "hour")
        
        //Set the arrow icons z-position to top
        imageContainer.layer.zPosition = 1
        secondContainer.layer.zPosition = 1
        thirdContainer.layer.zPosition = 1
    }

    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hanldeClockTick), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc private func hanldeClockTick() {
        
        if timeSec == 59 {
            timeSec = 0
            timeMin = timeMin + 1
        }else if timeMin == 59 {
            timeMin = 0
            timeHour = timeHour + 1
        }else if timeHour == 12 {
            timeHour = 0
            timeHour = 0
        } else {
            timeSec = timeSec + 1
        }
        
        hourLabel.text = String(format: "%02d", timeHour)
        minuteLabel.text = String(format: "%02d", timeMin)
        secondsLabel.text = String(format: "%02d", timeSec)
    }
    
    private func animate(onView: UIView, layer: CAShapeLayer, shapePath: CGPath, name: String) {
        layer.path = shapePath
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = shapePath
        
        layer.lineWidth = 20
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.strokeEnd = 0
        layer.position = onView.center
        layer.transform = CATransform3DRotate(CATransform3DIdentity, -CGFloat.pi / 2, 0, 0, 1)

        trackLayer.lineWidth = 20
        trackLayer.strokeColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = onView.center
        
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        animation.repeatCount = .infinity
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = true
        
        switch name {
        case "sec":
            layer.strokeColor = UIColor(red: 255/255, green: 21/255, blue: 45/255, alpha: 1.0).cgColor
            animation.duration = 60.0
            break
        case "min":
            layer.strokeColor = UIColor(red: 149/255, green: 219/255, blue: 3/255, alpha: 1.0).cgColor
            animation.duration = 60.0 * 60.0
            break
        case "hour":
            layer.strokeColor = UIColor(red: 84/255, green: 252/255, blue: 221/255, alpha: 1.0).cgColor
            animation.duration = 60.0 * 60.0 * 12.0
            break
        default:
            break
        }
        
        
        layer.add(animation, forKey: "Nil")
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(layer)
    }
}


