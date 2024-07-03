Pod::Spec.new do |s|
# 名称
s.name         = 'YLLoadingView'
# 版本号
s.version      = '0.0.2'
# 标题
s.summary      = '一个简单的加载框控件，可自定义程度高'
# 主页
s.homepage     = 'https://github.com/StudentLinn/YLLoadingView'
# 协议类型
s.license      = 'MIT'
# 作者
s.authors      = {'lin' => '792007074@qq.com'}
# 版本号
s.platform     = :ios, '12.0'
# 资源地址
s.source       = {:git => 'https://github.com/StudentLinn/YLLoadingView.git', :tag => s.version}
# 资源文件
s.source_files = 'Resource/**'
# icon
# s.resource     = 'ZXNavigationBar/ZXNavigationBar.bundle'
# 自动引用计数器
s.requires_arc = true
# swift版本
s.swift_versions = ['5.0']
# 依赖库
s.framework  = "UIKit"
s.dependency "SnapKit"

end
