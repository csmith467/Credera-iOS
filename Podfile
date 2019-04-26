# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Credera-iOS' do
    project 'Credera-iOS.xcodeproj', 'Debug_QA' => :debug, 'Debug' => :debug, 'Release_QA' => :release, 'Release' => :release
    
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!

    # Pods for Credera-iOS
    pod 'CocoaLumberjack/Swift', '3.4.2'
    pod 'SwiftLint', '0.30.1'
    pod 'PromisesSwift', '1.2.7'
    pod 'CareKit'
    pod 'ResearchKit'

    target 'Credera-iOSTests' do
        inherit! :search_paths
        # Pods for testing
        
        pod 'PromisesSwift', '1.2.7'
        pod 'OHHTTPStubs/Swift', '7.0.0'
    end

    target 'Credera-iOSUITests' do
        inherit! :search_paths
        # Pods for testing
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            if config.name == 'Release_QA' or config.name == 'Release'
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
            end
        end
    end
end
