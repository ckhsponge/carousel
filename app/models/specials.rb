class Specials < XmlCache
  
  def initialize
    
  end
  
  def file_name
    "specials.xml"
  end
  
  def to_xml
    doc = Hpricot(open("http://www.visitlasvegas.com/vegas/special-offers"))
    links = doc.search("//a[@class='item']")
    links.each do |link|
      puts link.attributes['href']
    end
    #links = links[0,2]
    xm = Builder::XmlMarkup.new(:indent => 2)
    xm.instruct!
    xm.browse do
      xm.items do
        links.each do |link|
          xm.item do
            puts link.attributes['href']
            url = "http://www.visitlasvegas.com#{link.attributes['href']}"
            xm.url url
            spans = link.search("//span")
            spans.each do |span|
              case span.attributes['class']
                when 'name'
                  xm.title clean_content(span.inner_html)
                when 'tag'
                  xm.neighborhood clean_content(span.inner_html)
                when 'deal'
                  xm.deal clean_content(span.inner_html)
              end
            end
            special_doc = Hpricot(open(url))
            meta_image = special_doc.at("//meta[@name='VLV-image']")
            xm.image "http://www.visitlasvegas.com#{meta_image['content']}" if meta_image
          end
        end
      end
    end
    return xm.target!
  end
  
  #deletes trailing spaces and |
  def clean_content(s)
    return "" unless s
    return s.gsub(/\s*\|?\s*$/, '')
  end
end