class Train
  attr_reader(:name, :id)

  define_method(:initialize) do |attrs|
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    DB.exec("SELECT * FROM trains").map do |train|
      Train.new(:name => train.fetch('name'), :id => train.fetch('id').to_i)
    end
  end

  define_singleton_method(:find) do |id|
    Train.all.keep_if { |train| train.id == id }.first
  end

  define_method(:==) do |other|
    @id == other.id && @name == other.name
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
    self
  end

  define_method(:update) do |attrs|
    @name = attrs.fetch(:name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id = #{@id}")
  end
end
