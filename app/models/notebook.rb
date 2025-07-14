class Notebook < ApplicationRecord
  enum :estado, { disponivel: 0, emprestado: 1, indisponivel: 2 }

  validates :marca, :modelo, :numero_patrimonio, :numero_serie, :identificacao, :data_compra, presence: true

  validates :numero_patrimonio, :numero_serie, :identificacao, uniqueness: true

  after_initialize :set_estado_padrao, if: :new_record?

  has_many :emprestimos, dependent: :destroy

  private

  def set_estado_padrao
    self.estado ||= :disponivel
  end
end
