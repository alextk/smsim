# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "smsim"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Tkachev"]
  s.date = "2012-03-09"
  s.description = "Ruby api for sms service provider: Smsim"
  s.email = "tkachev.alex@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/smsim.rb",
    "lib/smsim/core_ext/blank.rb",
    "lib/smsim/delivery_notification.rb",
    "lib/smsim/errors/delivery_notification_error.rb",
    "lib/smsim/errors/error.rb",
    "lib/smsim/errors/gateway_error.rb",
    "lib/smsim/errors/http_response_error.rb",
    "lib/smsim/errors/xml_response_error.rb",
    "lib/smsim/gateway.rb",
    "lib/smsim/http_executor.rb",
    "lib/smsim/xml_request_builder.rb",
    "lib/smsim/xml_response_parser.rb",
    "smsim.gemspec",
    "spec/smsim/delivery_notification_spec.rb",
    "spec/smsim/http_executor_spec.rb",
    "spec/smsim/xml_request_builder_spec.rb",
    "spec/smsim/xml_response_parser_spec.rb",
    "spec/smsim_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/smsim_gateway_macros.rb"
  ]
  s.homepage = "http://github.com/alextk/smsim"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.17"
  s.summary = "Ruby api for sms service provider: Smsim"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 2.7.0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<uuidtools>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 2.7.0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<uuidtools>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 2.7.0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

