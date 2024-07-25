##
# fetch_getty_records.rake
#
# This Rake task is a wrapper around the shell script
# lib/fetch_xml_getty_records.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Download the most recent dump of XML files from the Getty Research Portal."
task :fetch_getty_records do
  sh Settings[:lib].to_s + "/fetch_xml_getty_records"
end
