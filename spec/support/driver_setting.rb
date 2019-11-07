require 'rails_helper'
RSpec.configure do |config|
  config.before(:each, type: :system) do
    # driven_by(:rack_test) # デフォルト
    # driven_by(:selenium_chrome) # クロームを起動してテスト
    driven_by(:selenium_chrome_headless) # クロームを起動せずテスト
  end
end