class EmprestimosController < ApplicationController
  before_action :set_notebook, only: [:new, :create]
  before_action :set_emprestimo, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]
    @emprestimos = Emprestimo.includes(:notebook)

    if @query.present?
      filtro = "%#{@query.downcase}%"
      @emprestimos = emprestimos.where(
              "LOWER(notebooks.identificacao) LIKE :q OR
              LOWER(notebooks.numero_serie) LIKE :q OR
              LOWER(notebooks.numero_patrimonio) LIKE :q OR
              LOWER(notebooks.estado) LIKE :q
              OR LOWER(emprestimos.colaborador) LIKE :q OR
              LOWER(emprestimos.setor) LIKE :q OR",

              q: filtro
      ).references(:notebook)
    end

    @emprestimos = @emprestimos.order(created_at: :desc)
  end

  def new
    @emprestimo = @notebook.emprestimos.build(tipo: params[:tipo])

    if @emprestimo.tipo == "devolucao"
      ultimo_emprestimo = @notebook.emprestimos.where(tipo: "emprestimo").order(created_at: :desc).first
      if ultimo_emprestimo
        @emprestimo.colaborador = ultimo_emprestimo.colaborador
        @emprestimo.setor = ultimo_emprestimo.setor
      end
    end
  end

  def create
    @emprestimo = @notebook.emprestimos.build(emprestimo_params)

    case @emprestimo.tipo
    when "emprestimo"
      @notebook.update(estado: "emprestado")
    when "devolucao"
      @notebook.update(estado: "disponivel")
    when "baixa"
      @notebook.update(estado: "indisponivel")
    end

    if @emprestimo.save
      redirect_to notebooks_path, notice: "Movimentação registrada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @emprestimo.update(emprestimo_params)
      redirect_to notebooks_path, notice: "Registro atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @emprestimo.destroy
    redirect_to notebooks_path, notice: "Registro removido com sucesso."
  end

  private

  def set_notebook
    @notebook = Notebook.find(params[:notebook_id])
  end

  def set_emprestimo
    @emprestimo = Emprestimo.find(params[:id])
  end

  def emprestimo_params
    params.require(:emprestimo).permit(
      :tipo, :data_emprestimo, :colaborador, :setor,
      :data_entrega, :motivo_devolucao,
      :data_baixa, :justificativa
    )
  end
end
