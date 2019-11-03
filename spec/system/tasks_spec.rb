require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  before do
    driven_by(:rack_test)
  end
  describe "タスクの挙動テスト" do
    describe "ログイン前のケース" do
      # 異常系
      describe "タスクの新規作成画面" do
        context "権限がないため" do
          it "アクセスに失敗する" do
          end
        end
      end
      # 異常系
      describe "タスクの編集画面" do
        context "権限がないため" do
          it "アクセスに失敗する" do
          end
        end
      end
    end

    describe "ログイン後のケース" do
      describe "タスクの新規作成画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          it "タスクの新規作成に成功する" do
          end
        end
      end
      describe "タスクの編集画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          it "タスクの編集に成功する" do
          end
        end
        # 異常系
        context "他ユーザーの編集ページにアクセスした時" do
          it "権限がないためアクセスが失敗する" do
          end
        end
      end
      describe "タスクの一覧画面" do
        # 正常系
        context "Destroyボタンをクリックした時"
        it "タスクの削除に成功する" do
        end
      end
    end
  end
end
