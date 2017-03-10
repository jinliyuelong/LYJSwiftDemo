platform :ios, '9.0'
use_frameworks!

target ‘MyswiftDemo’ do
  pod 'MJRefresh'
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
  pod 'FMDB'


	
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end
