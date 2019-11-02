FactoryBot.define do
  factory :task do
    sequence(:title) {|n|"テストタイトル#{n}"}
    sequence(:content) {|n|"テストコンテント#{n}"}
    status {:todo}
    user_id {1}
  end
end
