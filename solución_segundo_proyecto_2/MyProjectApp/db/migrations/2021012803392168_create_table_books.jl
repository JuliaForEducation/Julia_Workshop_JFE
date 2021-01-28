module CreateTableBooks

import SearchLight.Migrations: create_table, column, primary_key, add_index, drop_table

function up()
  create_table(:books) do
    [
      primary_key()
      column(:column_name, :column_type)
    ]
  end

  add_index(:books, :column_name)
end

function down()
  drop_table(:books)
end

end
