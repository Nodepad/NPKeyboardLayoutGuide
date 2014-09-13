#
# Be sure to run `pod lib lint NPKeyboardLayoutGuide.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NPKeyboardLayoutGuide"
  s.version          = "1.0.0"
  s.summary          = "Add layout guide for keyboard to UIViewController"
  s.description      = <<-DESC
                       Layout guide for keyboard allows indirecty add constraints to keyboard.
                       
                       This class helps to raise text fields or other view when keyboard appears on screen.
                       DESC
  s.homepage         = "https://github.com/Nodepad/NPKeyboardLayoutGuide"
  s.license          = 'MIT'
  s.author           = { "Oleksii Kuchma" => "nod3pad@gmail.com" }
  s.source           = { :git => "https://github.com/Nodepad/NPKeyboardLayoutGuide.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/oleksiikuchma'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'NPKeyboardLayoutGuide' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
