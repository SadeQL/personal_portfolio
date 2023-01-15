defmodule PersonalPortfolio.Factory do
  alias PersonalPortfolio.Auth.User
  alias PersonalPortfolio.Repo

  def insert(_, attribues \\ %{})

  def insert(model_name, attributes) when is_atom(model_name) do
    model_name
    |> build(attributes)
    |> Repo.insert!()
  end

  def insert(struct, _) when is_struct(struct) do
    struct
    |> Repo.insert!()
  end

  def build(model_name, attributes) do
    model_name
    |> build()
    |> Map.merge(attributes)
    |> struct(%{})
  end

  def build(:user) do
    %User{}
    |> User.create_changeset(%{
      email: "helloworld+#{System.unique_integer([:positive])}@hello.fr",
      password: "12ssZe25",
      name: "foo",
      is_admin: true
    })
  end
end
