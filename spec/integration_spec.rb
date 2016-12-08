require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper.rb')

describe("City RESTful routes", {:type => :feature}) do
  describe("GET Cities") do
    it('shows a list of all of the cities') do
      City.new({:name => "Portland, OR"}).save()
      visit("/cities")
      expect(page).to have_content("Portland, OR")
    end
  end
  describe("POST Cities") do
    it('allows a user to create a city') do
      visit('/cities')
      fill_in('new-city-name', :with => 'Seattle, WA')
      click_button('Add City')
      visit('/cities')
      expect(page).to have_content('Seattle, WA')
    end
  end
end
