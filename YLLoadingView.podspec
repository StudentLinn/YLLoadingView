@version = "0.0.1"

Pod::Spec.new do |s|
  # 名称
  s.name         = "YLLoadingView"
  # 版本
  s.version      = @version
  # 简介
  s.summary      = "一个简单的加载框控件，可自定义程度高"
  # 主页
  s.homepage     = "https://github.com/StudentLinn/YLLoadingView"
  # 类型
  s.license      = { :type => "MIT", :file => "LICENSE" }
  # 作者
  s.author             = { "lin" => "792007074@qq.com" }
  # 限定ios
  s.platform     = :ios, "12.0"
  # 资源地址
  s.source       = { :git => "https://github.com/StudentLinn/YLLoadingView.git", :tag => "#{s.version}" }
  # 资源文件夹
  s.source_files  = "Resource/*.swift"
  # 依赖库
  s.framework  = "UIKit"
  s.dependency "SnapKit"

end
