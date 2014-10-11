require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "страница профиля" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "страница входа" do
    before { visit signup_page }

    let(:submit) { "Create my account" }

    describe "с неправильной информацией" do
      it "пользователь не создан" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "с правильной информацией" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "пользователь создан" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
