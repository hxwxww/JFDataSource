Pod::Spec.new do |s|

  s.name            = 'JFDataSource'
  s.version         = '0.0.1'
  s.summary         = 'A simple way to create dataSource and delegate for UITableView and UICollectionView'

  s.homepage        = 'https://github.com/hxwxww/JFDataSource'
  s.license         = 'MIT'

  s.author          = { 'hxwxww' => 'hxwxww@163.com' }
  s.platform        = :ios, '8.0'
  s.swift_version   = '5.0'

  s.source          = { :git => 'https://github.com/hxwxww/JFDataSource.git', :tag => s.version }

  s.source_files    = 'JFDataSource/JFDataSource/*.swift'

  s.frameworks      = 'Foundation', 'UIKit'

end
