FactoryBot.define do
  factory :emprestimo do
    tipo { "emprestimo" }
    data_emprestimo { Date.today }
    colaborador { Faker::Name.name }
    setor { "TI" }
    notebook

    trait :devolucao do
      tipo { "devolucao" }
      data_entrega { Date.today }
      motivo_devolucao { "Motivo qualquer" }
    end
  end
end
