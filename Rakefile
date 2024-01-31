# This rakefile should automatically include all the tasks in the rakelib

# define our project's environment by overriding the Settings defaults
require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

require 'pathname'

root = Pathname.new(File.dirname(__FILE__))
data = root + Pathname.new('data')
tmp = root + Pathname.new('tmp')
apps = root + Pathname.new('apps')
static_app = apps + Pathname.new('cicognara-static')

Settings[:root] = root
Settings[:data] = data
Settings[:tmp]  = tmp
Settings[:getty_tei_dir] = tmp + Pathname.new('getty_tei')
Settings[:catalogo_file] = data + Pathname.new('catalogo.tei.xml')
Settings[:catalogo_items_dir] = data + Pathname.new('catalogo_items')
Settings[:getty_resources_dir] = tmp + Pathname.new('resources')
Settings[:lib] = root + Pathname.new("lib")
Settings[:static_app_assets] = static_app + Pathname.new('assets')

# Note that all of our rake tasks are defined in .rake files in rakelib/
