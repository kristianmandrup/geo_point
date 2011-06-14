class GeoPoint
  module Calc
    def self.included(base)      
      base.send :include, ::GeoCalc
      base.send :include, Destination
      base.send :include, Intersection
      base.send :include, Midpoint
    end
  
    module Destination
      def destination_point brng, dist
        GeoPoint.new GeoCalc::Destination.destination_point(self, brng, dist).to_coords
      end

      # Returns the destination point from this point having travelled the given distance (in km) on the 
      # given initial bearing (bearing may vary before destination is reached)
      # 
      #   see http:#williams.best.vwh.net/avform.htm#LL
      # 
      # - Numeric bearing: Initial bearing in degrees
      # - Numeric dist: Distance in km
      # Returns GeoPoint: Destination point
      def self.destination_point base_point, brng, dist
        GeoPoint.new GeoCalc::Destination.destination_point(base_point, brng, dist).to_coords
      end
    end
  
    module Intersection
      # see(#intersection)
      # @returns [GeoPoint] Destination point (null if no unique intersection defined)    
      def self.intersection_point p1, brng1, p2, brng2
        GeoPoint.new GeoCalc::Intersection.intersection(p1, brng1, p2, brng2).to_coords
      end

      # see(#intersection)
      # @returns [GeoPoint] Destination point (null if no unique intersection defined)    
      def intersection_point brng1, p2, brng2
        GeoPoint.new GeoCalc::Intersection.intersection(self, brng1, p2, brng2).to_coords
      end
    end  

    module Midpoint  
      def midpoint_to point
        GeoPoint.new GeoCalc::Midpoint.midpoint_to(self, point).to_coords
      end

      # Returns the midpoint between this point and the supplied point.
      # see(http:#mathforum.org/library/drmath/view/51822.html for derivation)
      # 
      # @param [GeoPoint] base_point: Starting point (latitude, longitude)
      # @param [GeoPoint] point: Destination point (latitude, longitude)
      # @return [Array] Midpoint between this point and the supplied point
      #
      def self.midpoint_to base_point, point
        GeoPoint.new GeoCalc::Midpoint.midpoint_to(base_point, point).to_coords
      end
    end
  end
end