require 'rails_helper'

RSpec.describe EmprestimosController, type: :controller do
  let!(:notebook) { create(:notebook) }
  let!(:emprestimo) { create(:emprestimo, notebook: notebook) }

  let(:valid_emprestimo) {
    { tipo: 'emprestimo', data_emprestimo: Date.today, colaborador: "Fulano", setor: "TI" }
  }

  let(:invalid_emprestimo) {
    { tipo: nil }
  }

  describe "GET #new" do
    it "inicializa um novo empréstimo para o notebook" do
      get :new, params: { notebook_id: notebook.id, tipo: 'emprestimo' }
      expect(response).to be_successful
      expect(assigns(:emprestimo)).to be_a_new(Emprestimo)
      expect(assigns(:emprestimo).tipo).to eq('emprestimo')
    end
  end

  describe "POST #create" do
    context "com dados válidos" do
      it "cria o empréstimo e redireciona para o notebook" do
        expect {
          post :create, params: { notebook_id: notebook.id, emprestimo: valid_emprestimo }
        }.to change(Emprestimo, :count).by(1)
        expect(response).to redirect_to(notebook_path(notebook))
        expect(flash[:notice]).to eq("Movimentação registrada com sucesso!")
      end
    end

    context "com dados inválidos" do
      it "re-renderiza o formulário new" do
        post :create, params: { notebook_id: notebook.id, emprestimo: invalid_emprestimo }
        expect(response).to render_template(:new)
      end
    end
  end
end
