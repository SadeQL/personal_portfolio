defmodule PersonalPortfolio.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @create_attrs ~w(name password email is_admin)a

  @doc false
  def create_changeset(user, attrs) do
    user
    |> cast(attrs, @create_attrs)
    |> validate_required(@create_attrs)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
