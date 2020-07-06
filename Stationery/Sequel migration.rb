Sequel.migration do
  CT = Sequel::CURRENT_TIMESTAMP
  up do
    create_table(:artists) do
      primary_key :id
      String :name, null: false
      DateTime :created_at, null: false, default: CT
      DateTime :updated_at, null: false, default: CT
    end
  end

  down do
    drop_table(:artists)
  end
end