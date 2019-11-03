require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end
  describe "ユーザーのログイン挙動テスト" do

    describe "ログイン前のケース" do
      # 正常系
      context "フォーム入力値が全て正しい時" do
        it "ログインが成功する" do
        end
      end
      # 異常系
      context "フォームが未入力の時" do
        it "ログインが失敗する" do
        end
      end
    end

    describe "ログイン後のケース" do
      # 正常系
      context "ログアウトボタンをクリックした時" do
        it "ログアウトに成功する" do
        end
      end
    end
  end
end
