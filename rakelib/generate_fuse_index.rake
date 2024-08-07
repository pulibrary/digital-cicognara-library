require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
require 'pathname'
require "nokogiri"

desc "Generate index for Fuse indexer"
task :generate_fuse_index do
  item_pages_dir = "itempages/"
  index = []
  Settings[:catalogo_items_dir].glob("*.xml").each do |file|
    html_file = item_pages_dir + File.basename(file, "tei.xml") + "html"
    doc = Nokogiri::XML(File.read(file))
    teiHeader = doc.xpath("/xmlns:teiCorpus/xmlns:teiHeader")
    ciconum = Set.new()
    section_number = doc.xpath("//xmlns:sectionNumber").collect { |e| e.text }
    teiHeader.xpath("//xmlns:idno[@type='cico']").each { |e| ciconum << e.text }
    title = teiHeader.xpath("//xmlns:sourceDesc//xmlns:title").collect { |e| e.text }
    author = teiHeader.xpath("//xmlns:sourceDesc//xmlns:author").collect { |e| e.text }
    orgs = doc.xpath("//xmlns:orgName").collect { |e| e.text }
    people = doc.xpath("//xmlns:persName").collect { |e| e.text }
    langs = doc.xpath("//xmlns:textLang").collect { |e| e.text }
    dates =  doc.xpath("//xmlns:date").collect { |e| e.text }
    places = doc.xpath("//xmlns:pubPlace").collect { |e| e.text }
    keywords = doc.xpath("//xmlns:term").collect { |e| e.text }
    index << { filename: html_file,
               ciconum: ciconum.to_a,
               section_number: section_number,
               title: title,
               author: author,
               people: people,
               orgs: orgs,
               languages: langs,
               dates: dates,
               places: places,
               keywords: keywords,
 }
  end
  File.open(Settings[:static_app_assets] + Pathname.new("fuseindex.js"), "w") { |f|
    f.write("var searchIndex = ")
    f.write(index.to_json)}
end