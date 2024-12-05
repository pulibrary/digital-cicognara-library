##
# generate_viewer_pages.rake
#
# This Rake task is a wrapper around the shell script
# lib/generate_viewer_pages.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Generate the viewer pages for the static site."
task :generate_viewer_pages do
  sh Settings[:lib].to_s + "/generate_viewer_pages"
end
