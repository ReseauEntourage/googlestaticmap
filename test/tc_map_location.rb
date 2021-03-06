require 'test/unit'
require 'cgi'
require File.dirname(__FILE__) +  '/../lib/googlestaticmap'

class MapLocationTest < Test::Unit::TestCase #:nodoc: all
  def test_exception_no_location
    m = MapLocation.new
    assert_raise Exception do
      m.to_s
    end
  end

  def test_attributes_filled_in
    m = MapLocation.new(:latitude => 39, :longitude => -77)
    assert_equal "39", m.latitude
    assert_equal "-77", m.longitude
    assert_nil m.address
    m = MapLocation.new(:address => "Washington, DC")
    assert_equal "Washington, DC", m.address
    assert_nil m.latitude
    assert_nil m.longitude
  end
  
  def test_coordinates_array
    m = MapLocation.new(:latitude => 39.1, :longitude => -77.1)
    assert_equal 39.1, m.coordinates_array[0][0]
    assert_equal -77.1, m.coordinates_array[0][1]
    m = MapLocation.new(:address => "Washington, DC")
    assert_equal 0, m.coordinates_array.length
  end

  def test_with_address
    m = MapLocation.new(:address => "Washington, DC")
    s = ""
    assert_nothing_raised { s = m.to_s }
    assert_equal s, CGI.escape("Washington, DC")
  end

  def test_with_latitude_longitude
    m = MapLocation.new(:latitude => 39, :longitude => -77)
    s = ""
    assert_nothing_raised { s = m.to_s }
    assert_equal s, "39,-77"
  end
end
