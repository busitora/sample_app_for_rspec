require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:user) {FactoryBot.create(:user)}
  # let で インスタンス変数のように定義し、FBでデータを作成
  context "タイトルのバリデーションに関するテスト" do

    it "タイトルが空ならエラーになる" do
      task = Task.new(
       content: "テストコンテンツ",
       user_id: user.id,
       status: 0
      )
      expect(task).not_to be_valid
    end

    it "タイトルが重複していればエラーになる" do
      Task.create(
        title: "テストタイトル",
        content: "テストコンテンツ",
        user_id: user.id,
        status: 0
      )

      task = Task.new(
        title: "テストタイトル",
        content: "テストコンテンツ",
        user_id: user.id,
        status: 0
      )
      expect(task.valid?).to eq(false)
    end
  end

  context "ステータスのバリデーションに関するテスト" do

    it "ステータスが空ならエラーになる" do
      task = Task.new(
        content: "テストコンテンツ",
        user_id: user.id,
      )
      expect(task).not_to be_valid
    end
  end
end
