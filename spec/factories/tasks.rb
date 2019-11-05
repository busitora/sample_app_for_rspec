FactoryBot.define do
  factory :task do
    association :user
    sequence(:title) {|n| "テストタイトル#{n}"}
    sequence(:content) {|n| "テストコンテント#{n}"}
    status {:todo}
    sequence(:deadline) {|n| "#{Date.current + n.days}"}
  end
end
