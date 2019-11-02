require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:user) {FactoryBot.create(:user)}
  # let で インスタンス変数のように定義し、FBでデータを作成
  describe "タイトルのバリデーションに関するテスト" do
    context "タイトルが空の時" do
      it "エラーになる" do
        task = Task.new(
          content: "テストコンテンツ",
          user_id: user.id,
          status: 0
        )
        expect(task).not_to be_valid
      end
    end
    context "タイトルが重複している時" do
      it "エラーになる" do
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
  end

  describe "ステータスのバリデーションに関するテスト" do
    context "ステータスが空の時" do
      it "エラーになる" do
        task = Task.new(
          content: "テストコンテンツ",
          user_id: user.id,
        )
        expect(task).not_to be_valid
      end
    end
  end
end
