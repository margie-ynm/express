require('spec_helper.rb')

describe(City) do
  describe('#intialize') do
    it('add attributes to class') do
      @seattle = City.new({:name => "Seattle"})
      expect(@seattle.name).to eq('Seattle')
    end
  end
end
