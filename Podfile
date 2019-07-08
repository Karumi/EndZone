platform :ios, '13.0'

def app_development_pods
	pod 'SwiftLint', :configurations => ['Debug']
end

target 'EndZone' do
  app_development_pods

  pod "Solar"
  pod 'SDWebImage', :modular_headers => true

  target 'EndZoneTests' do
    inherit! :search_paths
  end

end
