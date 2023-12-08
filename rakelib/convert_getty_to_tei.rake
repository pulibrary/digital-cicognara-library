##
# convert_getty_to_tei.rake
#
# Generate a TEI file for each Getty record.
#
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Generate a TEI file for each Getty record."
task :convert_getty_to_tei do
  sh Settings[:lib].to_s + "/convert_getty_to_tei"
end
