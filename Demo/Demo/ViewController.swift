//
//  ViewController.swift
//  Demo
//
//  Created by Lin on 2024/4/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    /// 测试按钮
    lazy var testBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("test", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // 配置
        ylPopManager.setConfig { result in
            // 底部背景色
//            result.backViewMaskColor = .blue
            // 蒙层
            result.backViewHaveMask = false
            // 有图片时最小框
            result.popViewHaveImageMinSize = .init(width: 300, height: 300)
            result.loadingImage = UIImage(named: "PopLoading")
            result.successImage = UIImage(named: "PopSuccess")
            result.errorImage = UIImage(named: "PopSuccess")
            result.exitImage = UIImage(named: "PopSuccess")
        }
        
        view.addSubview(testBtn)
        testBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.width.height.equalTo(100)
        }
    }


}

extension ViewController {
    @objc func btnClick(_ btn : UIButton){
        // 弹出弹窗
        if btn.tag == 0 {
            ylPopManager.showTipsWithText("测试弹窗")
            btn.tag = 1
        } else if btn.tag == 1 {
            // 加载&&成功状态
            ylPopManager.showLoadingWithText("加载中")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
                ylPopManager.showSuccessWithText("加载成功")
            }
            btn.tag = 2
        } else if btn.tag == 2 {
            // 加载&&失败状态
            ylPopManager.showLoadingWithText("加载中")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
                ylPopManager.showErrorWithText("加载失败")
            }
            btn.tag = 0
        }
       
    }
}
