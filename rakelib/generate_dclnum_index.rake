require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
require "nokogiri"

desc "Generate an index of dclnum->[gettyrecord*]"
task :generate_dclnum_index do
  index = {}
  Settings[:getty_tei_dir].glob("*.xml").each do |file|
    doc = Nokogiri::XML(File.read(file))
    identifiers = doc.xpath("//xmlns:idno[@type='dcl']")
    identifiers.each do |idno|
      dcl = idno.text
      index[dcl] = [] unless index.has_key? dcl
      index[dcl] << File.basename(file)
    end
  end
  File.open(Settings[:tmp] + Pathname.new("dclindex.json"), "w") {
    |f| f.write(index.to_json)
  }
end
