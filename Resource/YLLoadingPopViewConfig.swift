//
//  YLLoadingPopViewConfig.swift
//  Demo
//
//  Created by Lin on 2024/4/30.
//

import Foundation
import UIKit

/// 加载弹窗弹窗配置文件
public struct YLLoadingPopViewConfig {
    //MARK: - 蒙层以及背景等设置
    /// 是否含有蒙层 => (默认为有)
    var backViewHaveMask : Bool = true
    
    /// 蒙层颜色 => (默认0.5透明度黑色)
    var backViewMaskColor : UIColor = .black.withAlphaComponent(0.5)
    
    
    
    //MARK: - 窗口部分配置
    /// 弹窗有图片时最小大小 => (默认为空)
    var popViewHaveImageMinSize : CGSize?
    
    /// 弹窗有图片时最大大小 => (默认为空)
    var popViewHaveImageMaxSize : CGSize?
    
    /// 窗口写死大小
    var popViewSizeEqual : CGSize?
    
    /// 弹窗背景色 =>  (默认0.8透明度黑色)
    var popViewBackGroundColor : UIColor = .black.withAlphaComponent(0.8)
    
    /// 弹窗圆角 => (默认8)
    var popViewCornerRadius : CGFloat = 8
    
    /// 弹窗是否默认含有关闭按钮 => (默认没有关闭按钮)
    var popViewHaveExitBtn : Bool = false
    
    
    
    //MARK: - 图片相关
    /// 加载图片 => (默认为空)
    var loadingImage : UIImage?
    
    /// 加载图片是否需要旋转 => (默认需要)
    var loadingRotate : Bool = true
    
    /// 加载图片旋转一次时长 => (默认2秒)
    var loadingRotateDuration : CGFloat = 2
    
    /// 加载图片大小 => (默认40,40)
    var loadingImageSize : CGSize = CGSize(width: 40, height: 40)
    
    /// 成功图片 => (默认为空)
    var successImage : UIImage?
    
    /// 成功后view停留多少秒 => (默认为1秒)
    var successDismissDelaySeconds : TimeInterval = 1
    
    /// 成功图片大小 => (默认40,40)
    var successImageSize : CGSize = CGSize(width: 40, height: 40)
    
    /// 失败图片 => (默认为空)
    var errorImage : UIImage?
    
    /// 失败后view停留多少秒 => (默认为2秒)
    var errorDismissDelaySeconds : TimeInterval = 2
    
    /// 失败图片大小 => (默认40,40)
    var errorImageSize : CGSize = CGSize(width: 40, height: 40)
    
    /// 关闭按钮图片
    var exitImage : UIImage?
    
    /// 关闭按钮图片大小
    var exitImageSize : CGSize = CGSize(width: 40, height: 40)
    
    /// 淡出动画时长,默认0.2
    var animateDismissDuration : TimeInterval = 0.2
    
    
    //MARK: - 文字相关
    /// 文字字体 => (默认大小18,regular系统字体)
    var textFont : UIFont = .systemFont(ofSize: 18, weight: .regular)
    
    /// 文字颜色 => (默认白色)
    var textColor : UIColor = .white
    
    /// 文字对齐方式 => (默认居中)
    var textAlignment : NSTextAlignment = .center
    
    /// 文字最多多少行 => (默认为0即无限换行)
    var textNumberOfLines : Int = 0
    
    /// 文字提示view停留多少秒 => (默认为1秒)
    var textDismissDelaySeconds : TimeInterval = 1

    //MARK: - 间距相关
    /// 文字有图片时间距(距上下左右)
    var textHaveImageContentinsert : UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    
    /// 文字无图片时间距(距上下左右)
    var textNoImageContentinsert : UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    
    /// 关闭图片间距(距上距右生效)
    var exitImageContentinsert : UIEdgeInsets = .init(top: 12, left: 0, bottom: 0, right: 16)
    
    /// 图片与上方间距
    var imagePaddingTop : CGFloat = 20
}
