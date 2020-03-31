//
//  ViewController.swift
//  UIProgressViewSample
//
//  Created by satoshi.marumoto on 2020/03/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label:UILabel!
    var progressView:UIProgressView!
    var progress:Float = 0.0
    var timer:Timer!
    var restartButton:UIButton!

    @objc func restart(_ s:UIButton) {

        timer.invalidate()
        progress = 0
        label.text = "please wait ..."
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                             target: self,
                             selector: #selector(ViewController.timerUpdate),
                             userInfo: nil,
                             repeats: true)

        // リセット時にアニメーションしたくないときはコメントアウトを解除
        //progressView.setProgress(progress, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// ラベル
        label = UILabel(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width - 20,height:20))
        var labelCenterPos = view.center
        labelCenterPos.y = labelCenterPos.y + 30
        label.center = labelCenterPos
        label.text = "please wait ..."
        label.textAlignment = .center
        view.addSubview(label)

        /// プログレスバー
        progressView = UIProgressView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width - 60,height:20))
        progressView.center = view.center
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 6.0)
//        progressView.progressTintColor = .blue
        progressView.trackTintColor = .orange
        progressView.setProgress(progress, animated: true)
        progressView.progressViewStyle = UIProgressView.Style.bar
        let image = UIImage(named: "park")
        progressView.progressImage = image
        view.addSubview(progressView)

        /// 再開ボタン
        restartButton = UIButton(frame: CGRect(x:0,y:0,width:80,height:40))
        var buttonCenterPos = view.center
        buttonCenterPos.y = UIScreen.main.bounds.height - 100
        restartButton.center = buttonCenterPos
        restartButton.setTitle("restart", for: .normal)
        restartButton.setTitleColor(.blue, for: .normal)
        restartButton.setTitleColor(.red, for: .highlighted)
        restartButton.addTarget(self, action: #selector(ViewController.restart(_:)), for: .touchUpInside)
        view.addSubview(restartButton)

        /// タイマー
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                             target: self,
                             selector: #selector(ViewController.timerUpdate),
                             userInfo: nil,
                             repeats: true)
    }

    @objc func timerUpdate() {
        progress = progress + 0.001
        if progress < 1.1 {  // 浮動小数点誤差のため、<= 1.0 だとtrueにならないことがある
            progressView.setProgress(progress, animated: true)
        } else {
            timer.invalidate()
            label.text = "Complete !"
        }
    }

}
