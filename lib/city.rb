class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attrs|
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id, nil)
  end
  define_singleton_method(:all) do
    #map through array and replace with city objects
    DB.exec('SELECT * FROM cities;').map do |city|
      City.new({:name => city.fetch('name'), :id => city.fetch('id').to_i})
    end
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end
  define_method(:==) do |other|
    @name == other.name && @id == other.id
  end
  define_method(:update) do |attrs|
    @name = attrs.fetch(:name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end
end
