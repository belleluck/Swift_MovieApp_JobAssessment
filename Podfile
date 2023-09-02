# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

target 'MovieApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieApp
  
  # https://cocoapods.org/pods/FirebaseCore
  pod 'Firebase/Core', '~> 8.9.1'
  
  pod 'Firebase/Database'
  
  # https://github.com/scalessec/Toast-Swift
  pod 'Toast-Swift', '~> 5.0.1'
  
  # https://github.com/hackiftekhar/IQKeyboardManager
  pod 'IQKeyboardManagerSwift', '~> 6.5.9'
  
  # https://github.com/krzyzanowskim/CryptoSwift
  # pod 'CryptoSwift', '~> 1.7.1'
  pod 'CryptoSwift'
  
  # https://github.com/stephencelis/SQLite.swift
  pod 'SQLite.swift', '~> 0.13.1'
  
  # https://github.com/Alamofire/Alamofire
  pod 'Alamofire', '~> 5.4.4'
  
  # https://github.com/drmohundro/SWXMLHash
  pod 'SWXMLHash', '~> 6.0.0'
  
  # https://github.com/evgenyneu/Cosmos
  pod 'Cosmos', '~> 23.0.0'

end
