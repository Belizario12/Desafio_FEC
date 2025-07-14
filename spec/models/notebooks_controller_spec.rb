require 'rails_helper'

RSpec.describe NotebooksController, type: :controller do
  let!(:notebook) { create(:notebook) }
  let(:valid_attributes) {
    { identificacao: "NB123", numero_patrimonio: "123456", estado: "disponivel" }
  }
  let(:invalid_attributes) {
    { identificacao: nil }
  }

  describe "GET #index" do
    it "retorna sucesso e carrega os notebooks" do
      get :index
      expect(response).to be_successful
      expect(assigns(:notebooks)).to include(notebook)
    end
  end

  describe "GET #show" do
    it "mostra o notebook" do
      get :show, params: { id: notebook.id }
      expect(response).to be_successful
      expect(assigns(:notebook)).to eq(notebook)
    end
  end

  describe "GET #new" do
    it "inicializa um novo notebook" do
      get :new
      expect(response).to be_successful
      expect(assigns(:notebook)).to be_a_new(Notebook)
    end
  end

  describe "POST #create" do
    context "com dados válidos" do
      it "cria um notebook e redireciona" do
        expect {
          post :create, params: { notebook: valid_attributes }
        }.to change(Notebook, :count).by(1)
        expect(response).to redirect_to(notebook_path(Notebook.last))
      end
    end

    context "com dados inválidos" do
      it "re-renderiza o formulário new" do
        post :create, params: { notebook: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "carrega o notebook para edição" do
      get :edit, params: { id: notebook.id }
      expect(response).to be_successful
      expect(assigns(:notebook)).to eq(notebook)
    end
  end

  describe "PATCH #update" do
    context "com dados válidos" do
      it "atualiza e redireciona" do
        patch :update, params: { id: notebook.id, notebook: { identificacao: "NB999" } }
        notebook.reload
        expect(notebook.identificacao).to eq("NB999")
        expect(response).to redirect_to(notebook_path(notebook))
      end
    end

    context "com dados inválidos" do
      it "re-renderiza o formulário edit" do
        patch :update, params: { id: notebook.id, notebook: { identificacao: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    context "quando não tem movimentações" do
      it "exclui o notebook e redireciona" do
        expect {
          delete :destroy, params: { id: notebook.id }
        }.to change(Notebook, :count).by(-1)
        expect(response).to redirect_to(notebooks_path)
        expect(flash[:notice]).to eq("Notebook excluído com sucesso.")
      end
    end

    context "quando tem movimentações" do
      before do
        create(:emprestimo, notebook: notebook)
      end

      it "não exclui e redireciona com alerta" do
        expect {
          delete :destroy, params: { id: notebook.id }
        }.not_to change(Notebook, :count)
        expect(response).to redirect_to(notebooks_path)
        expect(flash[:alert]).to eq("Não foi possível excluir o notebook pois existem movimentações associadas.")
      end
    end
  end
end
