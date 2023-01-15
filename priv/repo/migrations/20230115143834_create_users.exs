defmodule PersonalPortfolio.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

    create index(:users, :email, unique: true)
  end
end
