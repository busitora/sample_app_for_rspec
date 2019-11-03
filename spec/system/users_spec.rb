require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end
  describe "ユーザーの挙動テスト" do

    describe "ログイン前のケース" do
      describe "ユーザー新規登録画面" do
        # 正常系
        context "フォーム入力値が全て正しい時" do
          it "ユーザー新規作成に成功する" do
          end
        end

        # 異常系
        context "メールアドレスが未入力の時" do
          it "ユーザーの新規作成に失敗する" do
          end
        end
        context "登録済メールアドレスの時" do
          it "ユーザーの新規作成に失敗する" do
          end
        end
      end
    end
    describe "ログイン後のケース" do
      describe "ユーザー編集画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          it "ユーザーの編集に成功する" do
          end
        end

        # 異常系
        context "メールアドレスが未入力の時" do
          it "ユーザーの編集が失敗する" do
          end
        end
        context "登録済メールアドレスの時" do
          it "ユーザーの編集が失敗" do
          end
        end
      end

      describe "マイページにアクセスした時" do
        # 正常系
        context "自分のマイページの時" do
          it "新規作成したタスクが表示される" do
          end
        end
        # 異常系
        context "他人のマイページの場合" do
          it "権限がないためアクセスに失敗する" do
          end
        end
      end
    end

  end
end
