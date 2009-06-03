class Events < XmlCache
  
  def intialize
    
  end
  
  def file_name
    "events.xml"
  end
  
  def to_xml
    rss = RSS::Parser.parse(open('http://www.visitlasvegas.com/vegas/special-offers/vegas-right-now/vegas-right-now-rss-feed.jsp').read, false) 
    xm = Builder::XmlMarkup.new(:indent => 2)
    xm.instruct!
    xm.browse do
      xm.items do
        rss.items.each do |item|
          xm.item do
            puts item.link
            xm.link item.link
            doc = Hpricot(open(item.link))
            metas = doc.search("//meta")
            metas.each do |meta|
              case meta.attributes['name']
                when 'VLV-image'
                  xm.image "http://www.visitlasvegas.com#{meta.attributes['content']}"
                when 'VLV-title'
                  xm.title meta.attributes['content']
                when 'VLV-locationName'
                  xm.location meta.attributes['content']
                when 'VLV-showDates'
                  xm.dates meta.attributes['content']
                when 'VLV-showTime'
                  xm.time meta.attributes['content']
                when 'VLV-cost'
                  xm.price meta.attributes['content']
              end
            end
          end
        end
      end
    end
    return xm.target!
  end
end