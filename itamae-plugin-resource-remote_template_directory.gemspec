# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-remote_template_directory"
  spec.version       = "0.1.0"
  spec.authors       = ["tyage"]
  spec.email         = ["namatyage@gmail.com"]

  spec.summary       = %q{Extended itamae's remote_directory resource which each local file is template.}
  spec.description   = %q{Extended itamae's remote_directory resource which each local file is template.}
  spec.homepage      = "https://github.com/tyage/itamae-plugin-resource-remote_template_directory"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "serverspec"
end
