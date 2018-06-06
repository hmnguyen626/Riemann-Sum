platform :ios, '9.0'

target 'Riemann Sum' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Riemann Sum
  pod 'DDMathParser', :git => 'https://github.com/davedelong/DDMathParser.git', :tag => 'swift4'
  pod 'Charts'
  pod 'RealmSwift'
  pod 'ChartsRealm'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
