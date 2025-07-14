require "test_helper"

class EmprestimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emprestimo = emprestimos(:one)
  end

  test "should get index" do
    get emprestimos_url
    assert_response :success
  end

  test "should get new" do
    get new_emprestimo_url
    assert_response :success
  end

  test "should create emprestimo" do
    assert_difference("Emprestimo.count") do
      post emprestimos_url, params: { emprestimo: { colaborador: @emprestimo.colaborador, data_baixa: @emprestimo.data_baixa, data_emprestimo: @emprestimo.data_emprestimo, data_entrega: @emprestimo.data_entrega, justificativa: @emprestimo.justificativa, motivo_devolucao: @emprestimo.motivo_devolucao, notebook_id: @emprestimo.notebook_id, setor: @emprestimo.setor, tipo: @emprestimo.tipo } }
    end

    assert_redirected_to emprestimo_url(Emprestimo.last)
  end

  test "should show emprestimo" do
    get emprestimo_url(@emprestimo)
    assert_response :success
  end

  test "should get edit" do
    get edit_emprestimo_url(@emprestimo)
    assert_response :success
  end

  test "should update emprestimo" do
    patch emprestimo_url(@emprestimo), params: { emprestimo: { colaborador: @emprestimo.colaborador, data_baixa: @emprestimo.data_baixa, data_emprestimo: @emprestimo.data_emprestimo, data_entrega: @emprestimo.data_entrega, justificativa: @emprestimo.justificativa, motivo_devolucao: @emprestimo.motivo_devolucao, notebook_id: @emprestimo.notebook_id, setor: @emprestimo.setor, tipo: @emprestimo.tipo } }
    assert_redirected_to emprestimo_url(@emprestimo)
  end

  test "should destroy emprestimo" do
    assert_difference("Emprestimo.count", -1) do
      delete emprestimo_url(@emprestimo)
    end

    assert_redirected_to emprestimos_url
  end
end
