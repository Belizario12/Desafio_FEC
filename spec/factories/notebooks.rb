FactoryBot.define do
  factory :notebook do
    identificacao { Faker::Alphanumeric.alphanumeric(number: 5).upcase }
    numero_patrimonio { Faker::Number.number(digits: 9).to_s }
    estado { "disponivel" }
  end
end
