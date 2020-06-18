# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def testing
  pod 'Quick'
  pod 'Nimble'
  pod 'RxTest'
  pod 'RxBlocking'
end

target 'CleanArchitectureRxSwift_Gunter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  #Network	
  pod 'Alamofire'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'MoyaSugar',
    :git => 'https://github.com/devxoul/MoyaSugar.git',
    :branch => 'master'
  pod 'MoyaSugar/RxSwift',
    :git => 'https://github.com/devxoul/MoyaSugar.git',
    :branch => 'master'
  pod 'Kingfisher'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt', '~> 5'

  #Logging
  pod 'CocoaLumberjack/Swift'
  pod 'Then'
  
  #Lint
  pod 'SwiftLint'
  
end

target 'CleanArchitectureRxSwift_GunterTests' do
  inherit! :search_paths
  testing
end

target 'CleanArchitectureRxSwift_GunterUITests' do
  inherit! :search_paths
  testing
end

