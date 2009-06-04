class VisitLasVegasController < ApplicationController
  before_filter :set_header
  
  def events 
    render :xml => Events.new.read_file
  end
  
  def specials
    render :xml => Specials.new.read_file
  end
  
#  def specials_write
#    render :xml => Specials.new.to_xml
#  end
  
  protected
  def set_header
    headers['Cache-Control'] = 'max-age=300'
  end
end
