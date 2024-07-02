//
//  YLLoadingViewManager.swift
//  Demo
//
//  Created by Lin on 2024/4/30.
//

import Foundation

//MARK: - 版本号 0.0.3

//MARK: - 管理弹窗的工具类
/// 管理弹窗的工具类
open class YLLoadingViewManager {
    /// 单例
    static let share = YLLoadingViewManager()
    
    /// 当前在屏幕上的弹窗 nil即为未出现 可以访问到即为当前页面中有弹窗,提示弹窗无法访问到
    open var popView : YLLoadingPopView?
    /// 当前配置(每次初始化popView时使用)
    open var config : YLLoadingPopViewConfig = YLLoadingPopViewConfig()
}

//MARK: - 简写 在外部方便访问
/// 弹窗工具类单例简写 指向 => YLLoadingViewManager.share
public let ylPopManager = YLLoadingViewManager.share


//MARK: - 设置默认配置
extension YLLoadingViewManager {
    /// 传入配置
    /// - Parameter result: 配置文件
    public func setConfig(_ result:YLLoadingPopViewConfig) {
        self.config = result
    }
    /// 传入配置
    /// - Parameter resulut: 配置回调(可在回调中进行修改)
    public func setConfig(_ resulut:@escaping (inout YLLoadingPopViewConfig) -> Void){
        resulut(&self.config)
    }
}

//MARK: - 文字提示类型弹窗
extension YLLoadingViewManager {
    /// 展示提示语
    /// - Parameter text: 需要展示的提示语
    func showTipsWithText(_ text : String){
        /// 初始化新的弹窗
        let popView = YLLoadingPopView(config: config)
        /// 修改状态为该文字
        popView.changeState(.onlyTips, text: text)
        // 添加到keywindow上
        popView.addtoView(YLLoadingPopView.keyWindow)
    }
    
    /// 展示加载中弹窗
    /// - Parameter text: 需要展示的提示语
    /// - Parameter exitBlock: 关闭按钮回调
    func showLoadingWithText(_ text : String,
                             _ exitBlock : (() -> Void)? = nil){
        /// 判断当前是否有，没有的话初始化一个
        let popView = ylPopManager.popView ?? YLLoadingPopView(config: config)
        // 更新工具类中储存的view
        ylPopManager.popView = popView
        // 关闭按钮回调
        popView.exitBlock = exitBlock
        // 改变为加载状态
        popView.changeState(.loading, text: text)
        // 添加到keywindow上
        popView.addtoView(YLLoadingPopView.keyWindow)
    }
    
    /// 展示成功弹窗,并在配置的秒数后移除
    /// - Parameter text: 需要展示的提示语
    /// - Parameter completion: 动画完成回调
    func showSuccessWithText(_ text : String,
                             _ completion : (() -> Void)? = nil){
        // 如果当前没有正在加载的弹窗
        if popView == nil || popView?.state != .loading {
            // 进入加载状态
            showLoadingWithText(text)
        }
        /// 工具类中的popView
        let popView = ylPopManager.popView
        /// 标记为999
        popView?.tag = 999
        // 完成加载状态
        popView?.changeState(.success, text: text) {
            // 完成后移除工具类存储的加载中弹窗
            if ylPopManager.popView?.tag == popView?.tag {
                ylPopManager.popView = nil
            }
            completion?()
        }
    }
    
    /// 展示失败弹窗,并在配置的秒数后移除
    /// - Parameter text: 需要展示的提示语
    /// - Parameter completion: 动画完成回调
    func showErrorWithText(_ text : String,
                           completion : (() -> Void)? = nil){
        // 如果当前没有正在加载的弹窗
        if popView == nil || popView?.state != .loading {
            // 进入加载状态
            showLoadingWithText(text)
        }
        /// 工具类中的popView
        let popView = ylPopManager.popView
        /// 标记为999
        popView?.tag = 999
        // 完成加载状态
        popView?.changeState(.error, text: text) {
            // 完成后移除工具类存储的加载中弹窗
            if ylPopManager.popView?.tag == popView?.tag {
                ylPopManager.popView = nil
            }
            completion?()
        }
    }
}
