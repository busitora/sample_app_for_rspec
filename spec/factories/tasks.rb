FactoryBot.define do
  factory :task do
    title {"テストタイトル"}
    content {"テストコンテント"}
    status {:todo}
    user_id {1}
  end
end