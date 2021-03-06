Pod::Spec.new do |s|
  s.name         = 'TableDirector'
  s.version      = "1.0.2"
  s.source       = { :git => "https://github.com/dibadgo/TableDirector.git", :branch => "master" }
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Lightweight generic library allows you manage the UITableView and UICollectionView in a declare manner'
  s.homepage = 'https://github.com/dibadgo/TableDirector'
  s.authors = { 'Artyom Arabadzhiyan' => '3temal@gmail.com' }
  s.source = { :git => 'https://github.com/dibadgo/TableDirector.git', :tag => s.version }
  s.documentation_url = 'https://github.com/dibadgo/TableDirector'

  s.platforms             = { :ios => '11.0' }
  s.ios.deployment_target = '11.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'TableDirector/*.swift', 'TableDirector/Actions/*.swift', 'TableDirector/Builders/*.swift', 'TableDirector/Directors/*.swift', 'TableDirector/Other/*.swift'
end
