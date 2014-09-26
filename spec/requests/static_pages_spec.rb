require 'spec_helper'

describe "Static pages" do
	
	describe "Home page" do
		it "должна содержать 'Sample App'" do
			visit '/static_pages/home'
			expect(page).to have_content('Sample App')
    end

    it "должны содержать заголовок 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
    end
	end

	describe "Help page" do
		it "должна содержать 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
    end

    it "должны содержать заголовок 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
	end

	describe "About page" do
		it "должна содержать 'About us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About us')
    end

    it "должны содержать заголовок 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
	end
end
