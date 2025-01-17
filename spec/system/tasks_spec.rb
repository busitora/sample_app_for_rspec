require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  describe "タスクの挙動テスト" do
    let(:user) {create(:user)}
    let(:other_user) {(create(:user))}
    let(:task) {create(:task, user_id: user.id)}
    let(:other_task) {create(:task, user_id: other_user.id)}

    describe "ログイン前のケース" do
      # 異常系
      describe "タスクの新規作成画面" do
        context "権限がないため" do
          it "アクセスに失敗する" do
            visit new_task_path
            expect(current_path).to eq(login_path)
            expect(page).to have_content "Login required"
            # ログインせずに新規作成は出来ずに、login画面へリダイレクト
          end
        end
      end
      # 異常系
      describe "タスクの編集画面" do
        context "権限がないため" do
          it "アクセスに失敗する" do
            visit edit_task_path(user)
            expect(current_path).to eq(login_path)
            expect(page).to have_content "Login required"
            # ログインせずに編集画面にはリダイレクト出来ずに、login画面へ
          end
        end
      end
    end

    describe "ログイン後のケース" do
      before do
        login(user)
      end
      describe "タスクの新規作成画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          it "タスクの新規作成に成功する" do
            visit new_task_path
            fill_in "Title", with: "最初のタスク"
            fill_in "Content", with: "最初のコンテント"
            select "todo", from: "Status"
            click_button("Create Task")
            # expect(task_path(task.id)).to eq(current_path)
            # TODO この書き方だとletのtaskが呼ばれる。要修正
            expect(page).to have_content "Task was successfully created."
            expect(page).to have_content "最初のタスク"
            expect(page).to have_content "最初のコンテント"
          end
        end
      end
      describe "タスクの編集画面" do
        # 正常系
        context "フォームの入力値が全て正しい時" do
          it "タスクの編集に成功する" do
            visit edit_task_path(task)
            fill_in "Title", with: "2つ目のタスク"
            fill_in "Content", with: "2つめのタスクに変更"
            select "doing", from: "Status"
            fill_in "Deadline", with: '31 December 201'
            click_button("Update Task")
            expect(page).to have_content "Task was successfully updated."
            expect(page).to have_content task.reload.title
            expect(page).to have_content task.reload.content
          end
        end
        # 異常系
        context "他ユーザーの編集ページにアクセスした時" do
          it "権限がないためアクセスが失敗する" do
            # 他のタスクを作成
            visit edit_task_path(other_task)
            expect(current_path).to eq(root_path)
            # 他人の編集ページにアクセスしたのでリダイレクト
            expect(page).to have_content "Forbidden access."
          end
        end
      end
      describe "タスクの一覧画面" do
        # 正常系
        let!(:task) {create(:task, user_id: user.id)}
        # 呼ばれる前に呼ぶ
        context "Destroyボタンをクリックした時"
        it "タスクの削除に成功する" do
          login(user)
          task
          click_link("Destroy")
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "Task was successfully destroyed."
          expect(page).not_to have_content task.title
          expect(page).not_to have_content task.content
        end
      end
    end
  end
end
