FactoryBot.define do
  factory :task do
    title {'テストタイトル'}
    content {'テストコンテント'}
    status {:todo}
    user
  end
end
