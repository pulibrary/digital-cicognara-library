##
# generate_item_pages.rake
#
# This Rake task is a wrapper around the shell script
# lib/generate_item_pages.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Generate the item pages for the static site."
task :generate_item_pages do
  sh Settings[:lib].to_s + "/generate_item_pages"
end
