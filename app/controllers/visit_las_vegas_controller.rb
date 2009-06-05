class VisitLasVegasController < ApplicationController
  before_filter :set_header
  
  def events 
    render :xml => Events.new.read_file
  end
  
  def specials
    render :xml => Specials.new.read_file
  end
  
#  def specials_write
#    require 'hpricot'
#    render :xml => Specials.new.to_xml
#  end
#  
#  def events_write
#    require 'hpricot'
#    render :xml => Events.new.to_xml
#  end
  
  protected
  def set_header
    headers['Cache-Control'] = 'max-age=300'
  end
end
