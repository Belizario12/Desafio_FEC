json.extract! emprestimo, :id, :notebook_id, :tipo, :data_emprestimo, :colaborador, :setor, :data_entrega, :motivo_devolucao, :data_baixa, :justificativa, :created_at, :updated_at
json.url emprestimo_url(emprestimo, format: :json)
