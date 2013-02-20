# -*- encoding: utf-8 -*-
require File.expand_path('../lib/git-log/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander da Costa Monteiro"]
  gem.email         = ["alexmonteiro@gmail.com"]
  gem.description   = %q{"Get logs from local git project and put it on a collection"}
  gem.summary       = %q{"GitLog was created to provide a developer tool to easy access the commits logs of local folder project"}
  gem.homepage      = "https://github.com/alexmonteiro/git-log.git"

  #gem.files         = `git ls-files`.split($\)
  ignores = File.readlines(".gitignore").grep(/\S+/).map {|s| s.chomp }
  dotfiles = [".gitignore"]
  gem.files = Dir["**/*"].reject {|f| File.directory?(f) || ignores.any? {|i| File.fnmatch(i, f) } } + dotfiles
  
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "git-log"
  gem.require_paths = ["lib","config","generators"]
  gem.version       = Git::Log::VERSION
end
