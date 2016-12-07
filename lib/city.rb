class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attrs|
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id, nil)
  end
  define_singleton_method(:all) do
    #map through array and replace with city objects
    DB.exec('SELECT * FROM cities;').map do |city|
      City.new({:name => city.fetch('name'), :id => city.fetch('id')})
    end
  end
end
