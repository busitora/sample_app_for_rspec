require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  describe "ユーザーのログイン挙動テスト" do
    let(:user) {create(:user)}

    describe "ログイン前のケース" do
      # 正常系
      context "フォーム入力値が全て正しい時" do
        it "ログインが成功する" do
          # userを新規作成
          visit login_path
          fill_in "Email", with: user.email
          fill_in "Password", with: "password"
          click_button("Login")
          expect(root_path).to eq(current_path)
          expect(page).to have_content "Login successful"
          expect(page).to have_content "Tasks"
          # ログイン後にrootに飛んでいるか、rootのh1が表示されているかを検証
        end
      end
      # 異常系
      context "フォームが未入力の時" do
        it "ログインが失敗する" do
          visit login_path
          fill_in "Email", with: ""
          fill_in "Password", with: "password"
          click_button("Login")
          expect(login_path).to eq current_path
          expect(page).to have_content "Login failed"
        end
      end
    end

    describe "ログイン後のケース" do
      # 正常系
      context "ログアウトボタンをクリックした時" do
        it "ログアウトに成功する" do
          login(user)
          click_link("Logout")
          expect(root_path).to eq(current_path)
          expect(page).to have_content "Logged out"
          expect(page).to have_content "Tasks"
          # ログアウト後にrootに飛んでいるか、rootのh1が表示されているかを検証
        end
      end
    end
  end
end
