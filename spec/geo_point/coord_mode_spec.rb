require 'spec_helper'

# - www.movable-type.co.uk/scripts/latlong.html
describe GeoPoint do  
  describe '#coord_mode' do
    it 'should parse as lng, lat' do
      GeoPoint.coord_mode = :lng_lat        
      point = [2, 5].geo_point
      point.lat.should == 5
      point.lng.should == 2        
    end
    
    it 'should parse as lat, lng' do
      GeoPoint.coord_mode = :lat_lng        
      point = [5, 2].geo_point
      point.lat.should == 5
      point.lng.should == 2                
    end
  end
end

describe Array do  
  describe '#coord_mode' do
    it 'should parse as lng, lat' do
      GeoPoint.coord_mode = :lng_lat        
      [2, 5].to_lat.should == 5
      [2, 5].to_lng.should == 2
    end
    
    it 'should parse as lat, lng' do
      GeoPoint.coord_mode = :lat_lng        
      [5, 2].to_lat.should == 5
      [5, 2].to_lng.should == 2
    end
  end
end