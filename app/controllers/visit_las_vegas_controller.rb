class VisitLasVegasController < ApplicationController
  before_filter :set_header
  before_filter :production_not_allowed, :only => [:specials_write, :events_write]
  
  def events 
    render :xml => Events.new.read_file
  end
  
  def specials
    render :xml => Specials.new.read_file
  end
  
  #for testing
  def specials_write
    require 'hpricot'
    render :xml => Specials.new.to_xml
  end

  #for testing
  def events_write
    require 'hpricot'
    render :xml => Events.new.to_xml
  end
  
  protected
  def set_header
    headers['Cache-Control'] = 'max-age=300'
  end
  
  def production_not_allowed
    raise "not in production" if Rails.env.production?
  end
end
