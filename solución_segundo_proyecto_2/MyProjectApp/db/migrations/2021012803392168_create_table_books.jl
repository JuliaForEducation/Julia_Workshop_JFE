module CreateTableBooks

import SearchLight.Migrations: create_table, column, primary_key, add_index, drop_table

function up()
  create_table(:books) do
    [
      primary_key()
      column(:title, :string, limit = 100)
      column(:author, :string, limit = 100)
    ]
  end

  add_index(:books, :title)
  add_index(:books, :author)
end

function down()
  drop_table(:books)
end

end
