class GeoPoint
  module CoreExtension
    def to_coords    
      send(:"to_#{GeoPoint.coord_mode}")
    end

    def geo_point
      GeoPoint.new self
    end
  end
end  

[Array, Hash, String].each do |cls|
  cls.send :include, GeoPoint::CoreExtension
end

class Array
  def to_lat
    raise "Array must contain at least one element to return the latitude" if empty?
    case GeoPoint.coord_mode
    when :lng_lat
      self[1].to_lat 
    else
      first.to_lat
    end
  end

  def to_lng
    raise "Array must contain at least two elements to return the longitude" if !self[1]
    case GeoPoint.coord_mode
    when :lng_lat
      first.to_lng
    else
      self[1].to_lng      
    end      
  end
  
  def to_lat_lng
    raise "Array must contain at least two elements to be converted to latitude and longitude" if !(size >= 2)
    [first.to_lat, self[1].to_lng]
  end 

  def to_lng_lat
    to_lat_lng.reverse
    # [first.to_lng, self[1].to_lat]
  end   
end  