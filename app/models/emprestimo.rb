class Emprestimo < ApplicationRecord
  belongs_to :notebook

  validates :tipo, presence: true
  validate :validate_fields_based_on_tipo

  private 

  def validate_fields_based_on_tipo
    case tipo
    when 'emprestimo'
      errors.add(:data_emprestimo, "é obrigatório") if data_emprestimo.blank?
      errors.add(:colaborador, "é obrigatório") if colaborador.blank?
      errors.add(:setor, "é obrigatório") if setor.blank?
    when 'devolucao'
      errors.add(:data_entrega, "é obrigatório") if data_entrega.blank?
      errors.add(:motivo_devolucao, "é obrigatório") if motivo_devolucao.blank?
    when 'baixa'
      errors.add(:data_baixa, "é obrigatório") if data_baixa.blank?
      errors.add(:justificativa, "é obrigatório") if justificativa.blank?
    else
      errors.add(:tipo, "é inválido")
    end
  end

  after_create :update_notebook_estado

  private

  def update_notebook_estado
    case tipo
    when 'emprestimo'
      notebook.update(estado: :emprestado)
    when 'devolucao'
      notebook.update(estado: :disponivel)
    when 'baixa'
      notebook.update(estado: :indisponivel)
    end
  end
end
