# YLLoadingView
一个简单的加载框控件，可自定义程度高

``` swift
// 使用
// 配置
ylPopManager.setConfig { result in
    // 底部背景色
    result.backViewMaskColor = .blue
    // 蒙层
    result.backViewHaveMask = false
    // 有图片时最小框
    result.popViewHaveImageMinSize = .init(width: 300, height: 300)
    // 设置加载图片
    result.loadingImage = UIImage(named: "PopLoading")
    // 加载状态是否需要旋转
    result.loadingRotate = true
    // 成功图片
    result.successImage = UIImage(named: "PopSuccess")
    // 成功图片大小
    result.successImageSize = .init(width: 50, height: 50)
    // 报错图片
    result.errorImage = UIImage(named: "PopError")
    // 关闭图片
    result.exitImage = UIImage(named: "PopExit")
    // 提示语字体
    result.textFont = .systemFont(ofSize: 18, weight: .regular)
    // 淡出动画时长
    result.animateDismissDuration = 0.3
    // 失败后提示框停留多少秒
    result.errorDismissDelaySeconds = 2
    // 文字多少行
    result.textNumberOfLines = 0 // 自动换行
    // 关闭图片间距
    result.exitImageContentinsert = .init(top: 20, left: 0, bottom: 0, right: 20)
    // 文字距离图片/边框间距
    result.textNoImageContentinsert = .init(top: 8, left: 8, bottom: 16, right: 16)
    // 文字颜色
    result.textColor = .red
}
```

``` swift 
// 使用
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
```
