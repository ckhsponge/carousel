class Specials < XmlCache
  
  def initialize
    
  end
  
  def file_name
    "specials.xml"
  end
  
  def to_xml
    doc = Hpricot(open("http://www.visitlasvegas.com/vegas/special-offers"))
    links = doc.search("//a[@class='item']")
#    links.each do |link|
#      puts link.attributes['href']
#    end
    #links = links[0,2]
    links_array = []
    links.each do |link|
      line = {}
      line[:url] = "http://www.visitlasvegas.com#{link.attributes['href']}"
      spans = link.search("//span")
      spans.each do |span|
        case span.attributes['class']
          when 'name'
            line[:title] = clean_content(span.inner_html)
          when 'tag'
            line[:neighborhood] = clean_content(span.inner_html)
          when 'deal'
            line[:deal] = clean_content(span.inner_html)
        end
      end
      puts "loading #{line[:url]}"
      special_doc = Hpricot(open(line[:url]))
      meta_image = special_doc.at("//meta[@name='VLV-image']")
      line[:image] = "http://www.visitlasvegas.com#{meta_image['content']}" if meta_image
      links_array << line
    end
    links_array.sort! do |x,y|
      xs = x[:url].gsub(/.*offerId=/,'')
      xs = xs.gsub(/&.*/,'')
      ys = y[:url].gsub(/.*offerId=/,'')
      ys = ys.gsub(/&.*/,'')
      xs = xs.to_i
      ys = ys.to_i
      #puts "#{xs} - #{ys}"
      ys <=> xs
    end
    messages = open('http://statics.live.spongecell.com/lasvegas/summer09ad1/v2p/lib/en/Offers-items-message.xml').read
    xm = Builder::XmlMarkup.new(:indent => 2)
    xm.instruct!
    xm.browse do
      xm.items do
        links_array.each do |link|
          xm.item do
            puts link[:url]
            xm.link link[:url]
            xm.title link[:title]
            xm.neighborhood link[:neighborhood]
            xm.deal link[:deal]
            xm.image link[:image]
          end
        end
      end
      xm << messages
    end
    return xm.target!
  end
  
  #deletes trailing spaces and |
  def clean_content(s)
    return "" unless s
    return s.gsub(/\s*\|?\s*$/, '')
  end
end