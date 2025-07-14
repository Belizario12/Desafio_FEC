# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_12_235519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "emprestimos", force: :cascade do |t|
    t.bigint "notebook_id", null: false
    t.string "tipo"
    t.date "data_emprestimo"
    t.string "colaborador"
    t.string "setor"
    t.date "data_entrega"
    t.string "motivo_devolucao"
    t.date "data_baixa"
    t.text "justificativa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notebook_id"], name: "index_emprestimos_on_notebook_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.string "marca"
    t.string "modelo"
    t.string "numero_patrimonio"
    t.string "numero_serie"
    t.string "identificacao"
    t.date "data_compra"
    t.date "data_fabricacao"
    t.text "descricao"
    t.integer "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "emprestimos", "notebooks"
end
