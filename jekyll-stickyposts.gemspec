
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll/stickyposts/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-stickyposts"
  spec.version       = Jekyll::StickyPosts::VERSION
  spec.authors       = ["Alex Ibrado"]
  spec.email         = ["alex@ibrado.org"]

  spec.summary       = %q{StickyPosts: Sticky/pinned posts for Jekyll}
  spec.description   = %q{This plugin sticks/pins posts tagged sticky: true before all others. Optionally, the posts could additionally still appear where they normally would.}
  spec.homepage      = "https://github.com/ibrado/jekyll-stickyposts"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.16"
end
