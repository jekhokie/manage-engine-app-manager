# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manage_engine/app_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "manage-engine-app-manager"
  spec.version       = ManageEngine::AppManager::VERSION
  spec.authors       = [ "Justin Karimi" ]
  spec.email         = [ "jekhokie@gmail.com" ]
  spec.description   = %q{Interface with the ManageEngine ApplicationsManager Server}
  spec.summary       = %q{RESTful functionality to interface with the ApplicationsManager server to manage monitors}
  spec.homepage      = "https://github.com/jekhokie/manage-engine-app-manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = [ "lib" ]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "simplecov"
end
