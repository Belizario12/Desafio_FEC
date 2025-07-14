class NotebooksController < ApplicationController
  before_action :set_notebook, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      query = "%#{params[:query]}%"
      @notebooks = Notebook.left_outer_joins(:emprestimos).where(
        "notebooks.identificacao ILIKE :q OR notebooks.numero_serie ILIKE :q OR notebooks.numero_patrimonio ILIKE :q OR notebooks.estado::text ILIKE :q OR emprestimos.colaborador ILIKE :q OR emprestimos.setor ILIKE :q",
        q: query
      ).distinct
    else
      @notebooks = Notebook.all.order(created_at: :desc)
    end
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(notebook_params)

    respond_to do |format|
      if @notebook.save
        format.html { redirect_to notebooks_path, notice: "Notebook was successfully created." }
        format.json { render :show, status: :created, location: @notebook }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notebook.update(notebook_params)
        format.html { redirect_to notebooks_path, notice: "Notebook was successfully updated." }
        format.json { render :show, status: :ok, location: @notebook }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notebook = Notebook.find(params[:id])
    if @notebook.emprestimos.exists?
      respond_to do |format|
        format.html { redirect_to notebooks_path, alert: 'Não é possível excluir notebook com movimentações.' }
        format.json { render json: { error: 'Não é possível excluir notebook com movimentações.' }, status: :unprocessable_entity }
      end
    else
      @notebook.destroy
      respond_to do |format|
        format.html { redirect_to notebooks_path, notice: 'Notebook excluído com sucesso.' }
        format.json { head :no_content }
      end
    end
  end
  private

  def set_notebook
    @notebook = Notebook.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(
      :marca, :modelo, :numero_patrimonio, :numero_serie,
      :identificacao, :data_compra, :estado, :data_fabricacao, :descricao
    )
  end
end
