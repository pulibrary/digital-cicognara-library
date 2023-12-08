##
# winnow_getty_records.rake
#
# Remove files from the Getty records not related to Cicognara.
#
# The raw dump of Getty records contains many that are not part of the
# Cicognara Collection.  This script winnows out the unnecessary
# records, keeping only files that have cico numbers, a manifest, and
# are part of the Cicognara Collection.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
require "fileutils"
require "logger"
require "nokogiri"

desc "Remove files from the Getty records not related to Cicognara."
task :winnow_getty_records do
  Settings[:getty_resources_dir].glob("*.xml").each do |file|
    record = Nokogiri::XML(File.read(file))

    has_dcl = record.xpath('//dc:identifier').any? { |id| id.text =~ /^dcl:/ }

    in_collection = record.xpath('//dcterms:isPartOf').any?{ |c|
      c.text == "Cicognara Collection"
    }

    has_manifest = record.xpath('//dcterms:hasFormat').length > 0

    FileUtils.remove_file file unless
      has_dcl and in_collection and has_manifest
  end
end
