require 'rails_helper'

RSpec.describe Emprestimo, type: :model do
  let(:notebook) {
    Notebook.create!(
      marca: "HP", modelo: "EliteBook",
      numero_patrimonio: "987654",
      numero_serie: "SN987654321",
      identificacao: "NB002", data_compra: Date.today
    )
  }

  context "empréstimo" do
    subject {
      described_class.new(
        notebook: notebook,
        tipo: "emprestimo",
        data_emprestimo: Date.today,
        colaborador: "Lucas Belizario",
        setor: "TI"
      )
    }

    it { expect(subject).to be_valid }

    it "é inválido sem colaborador" do
      subject.colaborador = nil
      expect(subject).not_to be_valid
    end

    it "é inválido sem setor" do
      subject.setor = nil
      expect(subject).not_to be_valid
    end
  end

  context "devolução" do
    subject {
      described_class.new(
        notebook: notebook,
        tipo: "devolucao",
        data_entrega: Date.today,
        motivo_devolucao: "Término do uso"
      )
    }

    it { expect(subject).to be_valid }

    it "é inválido sem data de entrega" do
      subject.data_entrega = nil
      expect(subject).not_to be_valid
    end
  end

  context "baixa" do
    subject {
      described_class.new(
        notebook: notebook,
        tipo: "baixa",
        data_baixa: Date.today,
        justificativa: "Defeito irreparável"
      )
    }

    it { expect(subject).to be_valid }

    it "é inválido sem justificativa" do
      subject.justificativa = nil
      expect(subject).not_to be_valid
    end
  end
end
