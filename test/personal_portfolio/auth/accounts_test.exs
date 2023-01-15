defmodule PersonalPortfolio.Auth.AccountsTest do
  use PersonalPortfolio.DataCase, async: true
  alias PersonalPortfolio.Auth.Accounts

  describe "create_user/1" do
    setup do
      attrs = %{
        email: "hello@123.fr",
        password: "lolsalolsa",
        name: "foo",
        is_admin: true
      }

      user = Factory.insert(:user, attrs)

      {:ok, attrs: attrs, user: user}
    end

    test "should create a user with valid attributes", %{attrs: attrs} do
      assert {:ok, user} = Accounts.create_user(attrs)
      assert user.password_hash
      assert user.name == attrs.name
      assert user.email == attrs.email
    end

    test "when the same email exists should fail to create a new user", %{
      attrs: attrs
    } do
      assert {:ok, user} = Accounts.create_user(attrs)

      assert {:error, %Ecto.Changeset{errors: error}} =
               Accounts.create_user(%{
                 email: user.email,
                 password: "hellololol",
                 name: "louu",
                 is_admin: false
               })

      assert Enum.member?(
               error,
               {:email,
                {"has already been taken",
                 [constraint: :unique, constraint_name: "users_email_index"]}}
             )
    end
  end

  describe "autenticate_user/2" do
    setup do
      attrs = %{
        email: "hello@123.fr",
        password: "lolsalolsa",
        name: "foo",
        is_admin: true
      }

      user = Factory.insert(:user, attrs)

      {:ok, attrs: attrs, user: user}
    end

    test "should autenticate the user with correct email and password", %{user: user} do
      assert {:ok, _} = Accounts.authenticate_user(user.email, user.password)
    end

    test "with incorrect password should fail", %{user: user} do
      assert {:error, "Incorrect email or password"} =
               Accounts.authenticate_user(user.email, "12345678")
    end

    test "with incorrect email address should fail", %{user: user} do
      assert {:error, "Incorrect email or password"} =
               Accounts.authenticate_user("hellowww@kik.kk", user.password)
    end
  end
end
