require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

desc "Generate an index of ciconum->[dclnums]."
task :generate_ciconum_index do
  doc = Nokogiri::XML(File.read(Settings[:catalogo_file]))

  items = doc.xpath("//xmlns:list[@type='catalog']//xmlns:item")

  index = {}
  items.each do |item|
    n = item.xpath("@n").text
    dclnums = item.xpath("@corresp").text
    unless n.empty?
      unless dclnums.empty?
        index[n] = [] unless index.has_key? n
        dclnums.split(' ').each { |dcl| index[n] << dcl.strip }
      end
    end
  end

  File.open(Settings[:tmp] + "cicoindex.json", "w") { |f| f.write(index.to_json) }

end
