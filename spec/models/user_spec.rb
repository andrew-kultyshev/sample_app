require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "возвращает значение метода аутентификации" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "с правильным паролем" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "с неправильным паролем" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "имя не проходит" do
    before { @user.name = " " }
    it {should_not be_valid }
  end

  describe "email не проходит" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "имя слишком длинное" do
    before { @user.name = "a"*51 }
    it {should_not be_valid }
  end

  describe "неверный формат электронки" do
    it "invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_addresses|
        @user.email = invalid_addresses
        expect(@user).not_to be_valid
      end
    end
  end

  describe "верный формат электронки" do
    it "valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_addresses|
        @user.email = valid_addresses
        expect(@user).to be_valid
      end
    end
  end

  describe "email уже существует" do
    before do
      user_with_same_mail = @user.dup
      user_with_same_mail.email = @user.email.upcase
      user_with_same_mail.save
    end

    it { should_not be_valid }
  end

  describe "пароль не проходит" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "пароли не совпадают" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "пароль короткий" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "возвращает значение метода аутентификации" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "с правильным паролем" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "с неправильным паролем" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
