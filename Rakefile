require "rake"
require "rake/clean"
require "rake/gempackagetask"
require "fileutils"

def __DIR__
  File.dirname(__FILE__)
end

require File.expand_path(
 File.join(File.dirname(__FILE__), '.', 'lib', 'pdf-calendar'))

include FileUtils

# Rakefile from http://github.com/wycats/merb-core/tree/master/Rakefile

##############################################################################
# Package && release
##############################################################################
RUBY_FORGE_PROJECT  = "pdf-calendar"
PROJECT_URL         = "http://github.com/mat/pdf-calendar"
PROJECT_SUMMARY     = "PDF calendars. For a whole year. Using Ruby and Apache FOP."

AUTHOR = "Matthias Lüdtke"
EMAIL  = "email at matthias-luedtke dot de"

GEM_NAME    = "pdf-calendar"
PKG_BUILD   = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
GEM_VERSION = PDFCalendar::VERSION + PKG_BUILD

RELEASE_NAME    = "REL #{GEM_VERSION}"

spec = Gem::Specification.new do |s|
  s.name         = GEM_NAME
  s.version      = GEM_VERSION
  s.platform     = Gem::Platform::RUBY
  s.author       = AUTHOR
  s.email        = EMAIL
  s.homepage     = PROJECT_URL
  s.summary      = PROJECT_SUMMARY
  s.bindir       = "bin"
  s.description  = PROJECT_SUMMARY
  s.executables  = %w( pdf-calendar )
  s.require_path = "lib"
  s.files        = %w( LICENSE README.markdown Rakefile ) + Dir["{lib,bin,test,templates,examples}/**/*"]

  # rdoc
  s.has_rdoc         = false
 end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

CLEAN.include ["pkg", "*.gem"]

task 'pdf-calendar' => [:clean, :package]

##############################################################################
# Github
##############################################################################
namespace :github do
  desc "Update Github Gemspec"
  task :update_gemspec do
    skip_fields = %w(new_platform original_platform)
    integer_fields = %w(specification_version)

    result = "Gem::Specification.new do |s|\n"
    spec.instance_variables.each do |ivar|
      value = spec.instance_variable_get(ivar)
      name  = ivar.split("@").last
      next if skip_fields.include?(name) || value.nil? || value == "" || (value.respond_to?(:empty?) && value.empty?)
      if name == "dependencies"
        value.each do |d|
          dep, *ver = d.to_s.split(" ")
          result <<  "  s.add_dependency #{dep.inspect}, #{ver.join(" ").inspect.gsub(/[()]/, "")}\n"
        end
      else
        case value
        when Array
          value =  name != "files" ? value.inspect : value.inspect.split(",").join(",\n")
        when String
          value = value.to_i if integer_fields.include?(name)
          value = value.inspect
        else
          value = value.to_s.inspect
        end
        result << "  s.#{name} = #{value}\n"
      end
    end
    result << "end"
    File.open(File.join(File.dirname(__FILE__), "#{spec.name}.gemspec"), "w"){|f| f << result}
  end
end

##############################################################################
# SYNTAX CHECKING
##############################################################################

task :check_syntax do
  `find . -name "*.rb" |xargs -n1 ruby -c |grep -v "Syntax OK"`
  puts "* Done"
end

