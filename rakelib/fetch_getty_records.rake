##
# fetch_getty_records.rake
#
# Remove files from the Getty records not related to Cicognara.
#
# The raw dump of Getty records contains many that are not part of the
# Cicognara Collection.  This script winnows out the unnecessary
# records, keeping only files that have cico numbers, a manifest, and
# are part of the Cicognara Collection.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Download all Getty Portal records."
task :fetch_getty_records do
  sh Settings[:lib].to_s + "/fetch_xml_getty_records"
end
