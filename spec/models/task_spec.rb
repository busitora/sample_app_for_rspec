require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "バリデーションのテスト" do
    let(:user) {create(:user)}
    # let(:task) {create(:task)}
    # let で インスタンス変数のように定義し、FBでデータを作成

    # 正常系
    context "バリデーションが全て正しい時" do
      it "エラーにならない" do
        task = build(:task)
        # build が FB のメソッドでtasks.rbから:task を呼んでくる
        expect(task).to be_valid
      end
    end

    # 異常系
    describe "タイトルのバリデーションに関するテスト" do
      context "タイトルが空の時" do
        it "エラーになる" do
          task = build(:task, title: "")
          # create ではなく build。 validation は create の前に走る。タイトルを空にしたケース
          expect(task).not_to be_valid
        end
      end

      context "タイトルが重複している時" do
        it "エラーになる" do
          task = create(:task)
          # Factory.Botから tasks.rb を呼びtaskを登録
          duplicated_task = build(:task, title: task.title)
          expect(duplicated_task.valid?).to eq(false)
        end
      end
    end

    describe "ステータスのバリデーションに関するテスト" do
      context "ステータスが空の時" do
        it "エラーになる" do
          task = build(:task, status: "")
          expect(task).not_to be_valid
        end
      end
    end
  end
end
