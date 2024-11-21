# frozen_string_literal: true
##
# cicofile_generator.rb
#
# Generates a tei:teiCorpus document for each Cicognara Catalogo item.
#
# The teiCorpus contains a teiHeader for the document, identifying it
# as a document in the Digital Cicognara Library.  The teiCorpus
# encapsulates tei:TEI elements for each of the Getty resources
# associated with the item.
##

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
require "nokogiri"
require "pathname"
require "json"
require 'erb'
require 'fileutils'

desc "Generate the TEI corpus files for the Catalogo items."
task :generate_item_files do

  # The dcl_index is a json file generated by the :dclnum_index Rake
  # task. Its entries are of the form {dclnum : [getty_xml*]}
  # dcl_index = JSON.parse(File.read("../tmp/dclindex.json"))
  dcl_index = JSON.parse(File.read(Settings[:tmp] + "dclindex.json"))


  # corpus is an ERB template wrapper used to contain the TEI elements
  # for each dcl resource .
  corpus = ERB.new <<-EOF
  <teiCorpus xmlns="http://www.tei-c.org/ns/1.0">
<teiHeader>
    <fileDesc>
                <titleStmt>
            <title>Catalogo Cicognara Number <%= n %></title>
        </titleStmt>
        <publicationStmt>
            <publisher>
               <orgName>Digital Cicognara Library</orgName>
               <ref>https://cicognara.org</ref>
            </publisher>
            <idno type="cico"><%= n %></idno>
        </publicationStmt>
        <sourceDesc>
            <%= bibl %>
        </sourceDesc>
    </fileDesc>
</teiHeader>
        <%= getty_docs %>
</teiCorpus>
EOF


  # Make sure we have a place to put them.
  FileUtils.mkdir_p Settings[:catalogo_items_dir]


  # Construct a list of catalog items by reading them from the Catalogo
  # file.

  doc = Nokogiri::XML(File.read(Settings[:catalogo_file]))
  items = doc.xpath("//xmlns:list[@type='catalog']//xmlns:item")

  ##
  # Generate a tei:teiCorpus file for each Cicognara item.  Extract the
  # cico number and the <bibl> element(s) from the
  # <item> to insert as bindings into the corpus template.
  ##

  items.each do |item|
    n = item.xpath("@n")
    bibl = item.xpath("xmlns:bibl")
    
    # The dclnums are encoded as values in the @corresp attribute of the
    # <item>.  Compile an array of corresponding TEI documents by
    # looking up the dclnum in the dcl_index and appending their string
    # representations to the array.
    getty_docarray = []
    
    corresps = item.xpath("@corresp").text
    c2 = corresps.split(' ')
    dclnums = c2.collect { |x| x.split(":")[1]}
    
    dclnums.each do |dclnum|
      files = dcl_index[dclnum]
      if files
        files.each do |file|
          doc = File.open(Settings[:getty_tei_dir] + file) { |f| Nokogiri::XML(f) }
          # To avoid including the xml declaration and any processing
          # instructions at the top of the document, only append the
          # root of the document (the <TEI> element).
          
          getty_docarray << doc.root.to_s
        end
      end
    end 
    
    getty_docs = getty_docarray.join("\n")
    corpus_doc = corpus.result(binding)
    item_path = Settings[:catalogo_items_dir] + Pathname("#{n}.tei.xml")
    
    File.open(item_path, "w") { |f| f.write corpus_doc }
    
  end
end
