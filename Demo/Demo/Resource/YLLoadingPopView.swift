//
//  YLLoadingPopView.swift
//  Demo
//
//  Created by Lin on 2024/4/30.
//

import UIKit
import SnapKit

/// 加载弹窗状态枚举
public enum YLLoadingPopViewState : Int {
    /// 默认 => 未展示
    case normal = 0
    /// 文字提示 => 已展示
    case onlyTips = 1
    /// 加载中 => 已展示
    case loading = 2
    /// 成功 => 已展示
    case success = 3
    /// 失败 => 已展示
    case error = 4
}

/// 加载弹窗
public class YLLoadingPopView : UIView {
    //MARK: 私有属性
    
    
    //MARK: 可访问属性
    /// 当前状态
    public var state : YLLoadingPopViewState = .normal
    
    /// 可修改的配置 => (单次修改)
    public var config : YLLoadingPopViewConfig = ylPopManager.config {
        didSet {
            changeConfig()
        }
    }
    
    /// 关闭回调
    public var exitBlock : (() -> Void)?
    
    //MARK: 控件相关
    
    
    /// 弹出操作框,居中
    public lazy var popCenterYView : UIView = {
        let view = UIView()
        // 设置背景色
        view.backgroundColor = config.popViewBackGroundColor
        // 设置圆角
        view.layer.cornerRadius = config.popViewCornerRadius
        // 截取
        view.clipsToBounds = true
        
        return view
    }()
    
    /// 提示文本
    public lazy var tipsLab : UILabel = {
        let lab = UILabel()
        // 设置对齐方式
        lab.textAlignment = config.textAlignment
        // 换行
        lab.numberOfLines = config.textNumberOfLines
        // 设置文字颜色
        lab.textColor = config.textColor
        // 设置字体
        lab.font = config.textFont
        
        return lab
    }()
    
    /// 状态展示图片
    public lazy var stateImageView : UIImageView = {
        let imv = UIImageView()
        /// 先传入加载中图片
        imv.image = config.loadingImage
        // 如果需要旋转
        if config.loadingRotate {
            //开始旋转
            let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnim.fromValue = 0
            rotationAnim.toValue = Double.pi * 2
            rotationAnim.repeatCount = MAXFLOAT
            rotationAnim.duration = config.loadingRotateDuration
            imv.layer.add(rotationAnim, forKey: "transform.rotation.z")
        }
        
        return imv
    }()
    
    /// 关闭按钮
    public lazy var exitBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(config.exitImage, for: .normal)
        
        return btn
    }()
    
    //MARK: 程序入口
    /// 根据传入的配置进行修改(单次使用)
    init(config : YLLoadingPopViewConfig) {
        self.config = config
        super.init(frame: .zero)
        
        // 背景色
        backgroundColor = config.backViewMaskColor
        // 添加控件
        addSubview(popCenterYView)
        popCenterYView.addSubview(tipsLab)
        // 中心提示框的位置
        popCenterYView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        isUserInteractionEnabled = !config.backViewHaveMask
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 状态/配置更新
extension YLLoadingPopView {
    /// 更改配置
    private func changeConfig(){
        // 如果背景颜色修改了
        if backgroundColor != config.backViewMaskColor {
            backgroundColor = config.backViewMaskColor
        }
        // 如果弹窗框背景色修改了
        if popCenterYView.backgroundColor != config.popViewBackGroundColor {
            popCenterYView.backgroundColor = config.popViewBackGroundColor
        }
        
        // 如果圆角修改了
        if popCenterYView.layer.cornerRadius != config.popViewCornerRadius {
            popCenterYView.layer.cornerRadius = config.popViewCornerRadius
        }
        // 如果提示语对齐方式修改了
        if tipsLab.textAlignment != config.textAlignment {
            tipsLab.textAlignment = config.textAlignment
        }
        // 如果提示语字体修改了
        if tipsLab.font != config.textFont {
            tipsLab.font = config.textFont
        }
        // 如果提示语颜色修改了
        if tipsLab.textColor != config.textColor {
            tipsLab.textColor = config.textColor
        }
        // 如果提示语行数修改了
        if tipsLab.numberOfLines != config.textNumberOfLines {
            tipsLab.numberOfLines = config.textNumberOfLines
        }
    }
    
    /// 更改状态
    /// - Parameters:
    ///   - state: 更改为什么状态
    ///   - text: 需要展示的文字
    ///   - completion: 完成回调
    public func changeState(_ state : YLLoadingPopViewState,
                            text : String?,
                            completion : (() -> Void)? = nil){
        // 更新文案
        tipsLab.text = text
        // 更新状态
        self.state = state
        /// 动画key
        let animateKey : String = "transform.rotation.z"
        switch state {
        case .normal: // 默认状态
            // 如果当前有父类的话移除
            if superview != nil {
                removeFromSuperview()
            }
            completion?()
        case .onlyTips: // 仅提示状态
            // 移除其他控件
            _ = removeSuperviewIfNeed(stateImageView)
            _ = removeSuperviewIfNeed(exitBtn)
            // 中心提示框的位置
            popCenterYView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
            }
            // 修改提示文本的约束
            tipsLab.snp.remakeConstraints { make in
                /// 间距
                let insert = config.textNoImageContentinsert
                make.top.equalToSuperview().offset(insert.top)
                make.leading.equalToSuperview().offset(insert.left)
                make.trailing.equalToSuperview().offset(-insert.right)
                make.bottom.equalToSuperview().offset(-insert.bottom)
            }
            removeWithAnimate(delay: config.errorDismissDelaySeconds, duration: config.animateDismissDuration, completion)
        case .loading: // 加载中状态
            // 修改为加载中状态,那么需要添加控件
            addsubViewIfNeed(stateImageView)
            // 更新图片
            stateImageView.image = config.loadingImage
            // 如果需要旋转并且当前没有该动画
            if config.loadingRotate && stateImageView.layer.animation(forKey: animateKey) == nil {
                //开始旋转
                let rotationAnim = CABasicAnimation(keyPath: animateKey)
                rotationAnim.fromValue = 0
                rotationAnim.toValue = Double.pi * 2
                rotationAnim.repeatCount = MAXFLOAT
                rotationAnim.duration = config.loadingRotateDuration
                stateImageView.layer.add(rotationAnim, forKey: animateKey)
            }
            // 中心提示框的位置
            popCenterYView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                /// 最小尺寸
                if let minSize = config.popViewHaveImageMinSize {
                    make.width.greaterThanOrEqualTo(minSize.width)
                    make.height.greaterThanOrEqualTo(minSize.height)
                }
                /// 最大尺寸
                if let maxSize = config.popViewHaveImageMaxSize {
                    make.width.greaterThanOrEqualTo(maxSize.width)
                    make.height.greaterThanOrEqualTo(maxSize.height)
                }
            }
            // 状态图片与关闭按钮的约束
            stateImageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(config.imagePaddingTop)
                make.centerX.equalToSuperview()
                make.width.equalTo(config.loadingImageSize.width)
                make.height.equalTo(config.loadingImageSize.height)
            }
            // 更新提示约束
            updateTipsLabConstraintsHaveImage()
            // 如果有关闭按钮
            if config.popViewHaveExitBtn {
                // 添加控件并增加约束
                addsubViewIfNeed(exitBtn)
                exitBtn.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(config.exitImageContentinsert.top)
                    make.trailing.equalToSuperview().offset(config.exitImageContentinsert.right)
                    make.width.equalTo(config.exitImageSize.width)
                    make.height.equalTo(config.exitImageSize.height)
                }
            }
            completion?()
        case .success: // 成功状态
            // 移除动画
            stateImageView.layer.removeAnimation(forKey: animateKey)
            // 更新图片
            stateImageView.image = config.successImage
            // 状态图片与关闭按钮的约束
            stateImageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(config.imagePaddingTop)
                make.width.equalTo(config.successImageSize.width)
                make.height.equalTo(config.successImageSize.height)
            }
            // 更新提示约束
            updateTipsLabConstraintsHaveImage()
            // 带动画移除并传出回调
            removeWithAnimate(delay: config.successDismissDelaySeconds, duration: config.animateDismissDuration, completion)
        case .error: // 报错状态
            // 移除动画
            stateImageView.layer.removeAnimation(forKey: animateKey)
            // 更新图片
            stateImageView.image = config.errorImage
            // 状态图片与关闭按钮的约束
            stateImageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(config.imagePaddingTop)
                make.width.equalTo(config.successImageSize.width)
                make.height.equalTo(config.successImageSize.height)
            }
            // 更新提示约束
            updateTipsLabConstraintsHaveImage()
            // 带动画移除并传出回调
            removeWithAnimate(delay: config.errorDismissDelaySeconds, duration: config.animateDismissDuration, completion)
        }
    }
    
    /// 有图片的情况下更新约束
    private func updateTipsLabConstraintsHaveImage(){
        // 提示语修改
        tipsLab.snp.remakeConstraints { make in
            /// 有图片时候间距
            var insert = config.textHaveImageContentinsert
            // 如果没有文案的话就不用有文字的间距
            if tipsLab.text == "" || tipsLab.text == nil {
                insert = config.textNoImageContentinsert
            }
            make.top.equalTo(stateImageView.snp.bottom).offset(insert.top)
            make.leading.equalToSuperview().offset(insert.left)
            make.trailing.equalToSuperview().offset(-insert.right)
            make.bottom.equalToSuperview().offset(-insert.bottom)
        }
    }
    
    /// 如果没有父类的话就添加
    private func addsubViewIfNeed(_ view : UIView){
        if view.superview == nil {
            popCenterYView.addSubview(view)
        }
    }
    
    /// 如果有父类的话需要移除
    private func removeSuperviewIfNeed(_ view : UIView) -> Bool {
        // 如果有父控件
        if view.superview != nil {
            // 那么移除
            view.removeFromSuperview()
            return true
        }
        return false
    }
    
    // 传递点击事件
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 如果需要蒙层就不让传递下去
        if config.backViewHaveMask {
            return false
        }
        // 其他状态允许
        return true
    }
}

//MARK: - 出现与消失
extension YLLoadingPopView {
    /// 添加到view上
    public func addtoView(_ view : UIView?){
        view?.addSubview(self)
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// 带动画移除
    /// - Parameter delay: 延迟多久执行动画
    /// - Parameter duration: 动画时长
    /// - Parameter completion: 完成回调
    public func removeWithAnimate(delay : TimeInterval,
                                  duration : TimeInterval,
                                  _ completion : (() -> Void)?){
        // 执行淡出动画
        UIView.animate(withDuration: duration, delay: delay) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
            completion?()
        }
    }
}

//MARK: - 关闭按钮点击事件
extension YLLoadingPopView {
    /// 关闭按钮点击事件
    @objc private func exitBtnClick(){
        // 移除
        self.removeWithAnimate(delay: 0, duration: config.animateDismissDuration) { [weak self] in
            self?.exitBlock?()
        }
    }
}

//MARK: - 寻找keyWindow方法
extension YLLoadingPopView {
    /// keywindow,判断13以上与以下
    static var keyWindow: UIWindow? {
        // Get connected scenes
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
            // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
                .first(where: \.isKeyWindow)
        } else {
            // Fallback on earlier versions
            return UIApplication.shared.keyWindow
        }
    }
}
