require 'rails_helper'

RSpec.describe Notebook, type: :model do
  subject {
    described_class.new(
      marca: "Dell",
      modelo: "Inspiron 15",
      numero_patrimonio: "123456",
      numero_serie: "SN123456789",
      identificacao: "NB001",
      data_compra: Date.today,
      data_fabricacao: "2023-01-01",
      descricao: "Notebook de testes"
    )
  }

  it "é válido com todos os campos preenchidos" do
    expect(subject).to be_valid
  end

  it "é inválido sem modelo" do
    subject.modelo = nil
    expect(subject).not_to be_valid
  end

  it "é inválido sem número de série" do
    subject.numero_serie = nil
    expect(subject).not_to be_valid
  end

  it "é inválido sem identificação" do
    subject.identificacao = nil
    expect(subject).not_to be_valid
  end

  it "é inválido sem data de compra" do
    subject.data_compra = nil
    expect(subject).not_to be_valid
  end

  it "não permite duplicidade de numero_serie, numero_patrimonio e identificacao" do
    subject.save!
    outro = described_class.new(subject.attributes.except("id"))
    expect(outro).not_to be_valid
  end

  it "tem estado padrão como disponível" do
    expect(subject.estado).to eq("disponivel")
  end

  it "permite transição de estado para emprestado" do
    subject.estado = "emprestado"
    expect(subject.emprestado?).to be true
  end

  it "permite transição de estado para indisponível" do
    subject.estado = "indisponivel"
    expect(subject.indisponivel?).to be true
  end

  it "aceita campos opcionais nulos" do
    subject.data_fabricacao = nil
    subject.descricao = nil
    expect(subject).to be_valid
  end
end
