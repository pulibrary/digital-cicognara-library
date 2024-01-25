require 'fileutils'
require 'nokogiri'
require 'json'

ns = {'tei' => "http://www.tei-c.org/ns/1.0"}

sourcedir = "#{File.dirname(__FILE__)}/../tmp/items"

records = []

Dir["#{sourcedir}/*.xml"].each do |file|
  corpus = Nokogiri::XML(File.read(file))
  fileDesc = corpus.xpath("tei:teiCorpus/tei:teiHeader/tei:fileDesc", ns)
  ciconum = fileDesc.xpath("tei:publicationStmt/tei:idno", ns).text

  docs = corpus.xpath('//tei:TEI', ns)

  docs.each do |doc|
    fileDesc = doc.xpath("tei:teiHeader/tei:fileDesc", ns)
    title = fileDesc.xpath('tei:titleStmt/tei:title', ns).text
    provider = fileDesc.xpath('tei:titleStmt/tei:respStmt/tei:orgName', ns).text
    monogr = fileDesc.xpath('tei:sourceDesc/tei:biblStruct/tei:monogr', ns)
    creator = monogr.xpath('tei:respStmt/tei:persName', ns).text
    language = monogr.xpath('tei:textLang', ns).text
    publisher = monogr.xpath('tei:imprint/tei:publisher', ns).text
    issued = monogr.xpath('tei:imprint/tei:date', ns).text
    terms = doc.xpath("//tei:profileDesc/tei:textClass/tei:keywords/tei:term", ns)
    dclnums = fileDesc.xpath("tei:publicationStmt/tei:idno[@type='dcl']", ns)

    subjectlist = []
    terms.each do |term|
      subjectlist << term.text
    end

    dclnumlist = []
    dclnums.each do |d|
      dclnumlist << d.text
    end
    
    record = {ciconum: ciconum,
              dclnums: dclnumlist,
              title: title,
              creator: creator,
              language: language,
              publisher: publisher,
              issued: issued,
              provider: provider,
              subjects: subjectlist,
             }
    records << record
  end
end

puts JSON.generate(records)

