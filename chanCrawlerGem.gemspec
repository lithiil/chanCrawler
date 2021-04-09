# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chanCrawlerGem/version'

Gem::Specification.new do |spec|
  spec.name = 'chanCrawlerGem'
  spec.version = ChanCrawlerGem::VERSION
  spec.authors = ['Lithiil']
  spec.email = ['tudorjamal@gmail.com']

  spec.summary = 'This gem downloads images, gifs and webms from 4chan threads'
  spec.description = 'This gem scowers 4chan (or any chan copy theoretically) searching for threads that
  contains key words specified by you on boards specified by you and downloads
  all the images, gifs and webms to a specified folder'
  spec.homepage = 'https://github.com/lithiil/chanCrawler'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/lithiil/chanCrawler'
    spec.metadata['changelog_uri'] = 'https://github.com/lithiil/chanCrawler'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'down'
  spec.add_development_dependency 'fileutils'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'open-uri'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
