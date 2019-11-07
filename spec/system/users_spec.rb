require "rails_helper"

RSpec.describe "Users", type: :system do

  describe "ユーザーの挙動テスト" do
    let(:user) {create(:user)}
    let(:other_user) {(create(:user))}
    let(:task) {create(:task, title: "最初のタスク", user_id: user.id)}

    describe "ログイン前のケース" do
      describe "ユーザー新規登録画面" do
        # 正常系
        # TODO visit~ clickまでは共通化もできそうだが保留
        context "フォーム入力値が全て正しい時" do
          it "ユーザー新規作成に成功する" do
            visit new_user_path
            fill_in "Email", with: "user@example.com"
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            # f.labelで生成された値を入力する
            click_button("SignUp")
            expect(login_path).to eq(current_path)
            expect(page).to have_content "User was successfully created."
            # ユーザーが作成されたことを検証する
            user = User.find_by(email: "user@example.com" )
            login(user)
            visit user_path(user)
            expect(page).to have_content user.email
            # ログイン画面でアドレスは確認できないのでマイページに行き登録されていることを確認
          end
        end

        # 異常系
        context "メールアドレスが未入力の時" do
          it "ユーザーの新規作成に失敗する" do
            visit new_user_path
            fill_in "Email", with: ""
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            click_button("SignUp")
            expect(page).to have_content "Email can't be blank"
            expect(users_path).to eq(current_path)
            # 現在のURLが、users_pathにレンダーされていることを検証
          end
        end
        context "登録済メールアドレスの時" do
          it "ユーザーの新規作成に失敗する" do
            visit new_user_path
            fill_in "Email", with: user.email
            fill_in "Password", with: "password"
            fill_in "Password confirmation", with: "password"
            click_button("SignUp")
            expect(users_path).to eq(current_path)
            expect(page).to have_content "Email has already been taken"
          end
        end
      end
      context "自分の編集ページにアクセスした時" do
        it "ログイン前なので推移に失敗する" do
          visit edit_user_path(user)
          expect(login_path).to eq(current_path)
          expect(page).to have_content "Login required"
        end
      end
    end
    describe "ログイン後のケース" do
      describe "ユーザー編集画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          # TODO login(user)も共通化できそうだが保留
          it "ユーザーの編集に成功する" do
            login(user)
            # moduleで切り出してuserとしてログイン
            visit edit_user_path(user)
            fill_in "Email", with: "test2@example.com"
            fill_in "Password", with: "password2"
            fill_in "Password confirmation", with: "password2"
            click_button("Update")
            expect(user_path(user)).to eq(current_path)
            expect(page).to have_content "User was successfully updated."
            expect(page).to have_content User.first.email
          end
        end

        # 異常系
        context "メールアドレスが未入力の時" do
          it "ユーザーの編集が失敗する" do
            login(user)
            visit edit_user_path(user)
            fill_in "Email", with: ""
            fill_in "Password", with: "password2"
            fill_in "Password confirmation", with: "password2"
            click_button("Update")
            expect(user_path(user)).to eq(current_path)
            expect(page).to have_content "Email can't be blank"
          end
        end
        context "登録済メールアドレスの時" do
          it "ユーザーの編集が失敗する" do
            login(other_user)
            # 別のユーザーでログイン
            visit edit_user_path(other_user)
            fill_in "Email", with: user.email
            # let で定義済のアドレスに変更する
            fill_in "Password", with: "password2"
            fill_in "Password confirmation", with: "password2"
            click_button("Update")
            expect(user_path(other_user)).to eq(current_path)
            expect(page).to have_content "Email has already been taken"
          end
        end
        context "他人の編集ページへのアクセスの場合" do
          it "権限がないためアクセスに失敗する" do
            login(user)
            task
            visit edit_user_path(other_user)
            # 他人の編集ページは権限がない
            expect(user_path(user)).to eq(current_path)
            expect(page).to have_content "Forbidden access."
          end
        end
      end

      describe "マイページにアクセスした時" do
        # 正常系
        context "自分のマイページの時" do
          it "新規作成したタスクが表示される" do
            login(user)
            task
            # タスクをletで1件作成
            visit user_path(user)
            expect(page).to have_content "最初のタスク"
            # 新規作成したタスク(このテストでは指定)が表示されていることを検証
          end
        end
        # 異常系
        context "他人のマイページの時" do
          it "権限がないためアクセスに失敗する" do
            login(user)
            visit user_path(other_user)
            expect(user_path(user)).to eq(current_path)
            expect(page).to have_content "Forbidden access."
          end
        end
      end
    end
  end
end
