#
# Be sure to run `pod lib lint CoreDataSaver.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoreDataSaver'
  s.version          = '0.1.0'
  s.summary          = 'CoreDataSaver - components for work with CoreData.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "CoreDataSaver, CoreDataEntityFinderAndCreator & CoreDataRemover"

  s.homepage         = 'https://github.com/Evgeny Ivanov/CoreDataSaver'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Ivanov' => 'evgeny.ivanov.u@gmail.com' }
  s.source           = { :git => 'https://github.com/qaasx/coreDataSaver.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CoreDataSaver/Classes/**/*'
  
  s.frameworks = 'Foundation'
  s.dependency 'MagicalRecord', '~> 2.3.2'
end
