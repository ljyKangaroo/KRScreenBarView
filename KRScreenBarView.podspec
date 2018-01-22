Pod::Spec.new do |s|
  s.name         = 'KRScreenBarView'
  s.summary      = '简单的筛选表'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'ljyKangaroo' => '13560075334@163.com' }
  s.homepage     = 'https://github.com/ljyKangaroo/KRScreenBarView'

  s.ios.deployment_target = '8.0'

  s.source       = { :git => 'https://github.com/ljyKangaroo/KRScreenBarView.git', :tag => s.version }
  
  s.source_files = "KRScreenBarViewDemo/KRScreenBarViewDemo/KRScreenBarView/*.{h,m,c}"
  s.requires_arc = true
  s.frameworks = 'Foundation'

end
