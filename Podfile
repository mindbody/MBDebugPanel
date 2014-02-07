platform :ios, '7.0'

workspace 'MBDebugPanel'
xcodeproj 'MBDebugPanelDemo/MBDebugPanelDemo'

target :DemoPods, :exclusive => true do
  xcodeproj 'MBDebugPanelDemo/MBDebugPanelDemo'
  link_with 'MBDebugPanelDemo'
  pod 'MBDebugPanel', :path => './MBDebugPanel.podspec'
end

target :TestPods, :exclusive => true do
  xcodeproj 'MBDebugPanel/MBDebugPanel'
  link_with 'MBDebugPanelTests'
  pod 'Kiwi/XCTest'
end


