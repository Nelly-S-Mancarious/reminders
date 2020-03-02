require 'rails_helper'

RSpec.describe RemindersController, type: :controller do
  context "Get #index" do
    it 'can not be accessed without login' do
      get :index
      expect(response.success?).to eq(false)
    end
  end

  context "Get #show" do
    it 'can not be accessed without login' do
      user = User.create!(email: "test@test.com", password: "password")
      reminder = Reminder.create!(title: "title", month_day: 2, day_time: "06:40:00", user_id: user.id)
      get :show, params: {id: reminder.to_param}
      expect(response.success?).to eq(false)
    end
  end

  context "logged user" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context "Get #index" do
      it 'can be accessed after login' do
        get :index
        expect(response.success?).to eq(true)
      end
    end

    context "Get #show" do
      it 'can be accessed after login' do
        reminder = Reminder.create!(title: "title", month_day: 2, day_time: "06:40:00", user_id: @user.id)
        get :show, params: {id: reminder.to_param}
        expect(response.success?).to eq(true)
      end
    end

    context "Post # Delete" do
      it 'can be delete after login' do
        reminder = Reminder.create!(title: "title", month_day: 2, day_time: "06:40:00", user_id: @user.id)
        delete :destroy, params: {id: reminder.to_param}
        expect(Reminder.all.count).to eq(0)
      end
    end
  end
end
