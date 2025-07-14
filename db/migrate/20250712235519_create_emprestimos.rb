class CreateEmprestimos < ActiveRecord::Migration[8.0]
  def change
    create_table :emprestimos do |t|
      t.references :notebook, null: false, foreign_key: true
      t.string :tipo
      t.date :data_emprestimo
      t.string :colaborador
      t.string :setor
      t.date :data_entrega
      t.string :motivo_devolucao
      t.date :data_baixa
      t.text :justificativa

      t.timestamps
    end
  end
end
