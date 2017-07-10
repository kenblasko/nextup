defmodule Nextup.Web.AuthController do
  use Nextup.Web, :controller
  plug Ueberauth

  alias Nextup.Admin.User

  def signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} -> 
        name = user.name |> String.split |> List.first
        conn
          |> put_flash(:info, "Welcome back, #{name}!")
          |> put_session(:user_id, user.id)
          |> redirect(to: set_path(conn, :index))
      {:error, _reason} -> 
         conn
          |> put_flash(:error, "Error signing in.")
          |> redirect(to: set_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
      |> configure_session(drop: true)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: set_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = _params) do
    user_params = %{
      token: auth.credentials.token,
      name: auth.info.name,
      image: auth.info.image,
      email: auth.info.email,
      provider: provider,
      providerUID: auth.extra.raw_info.user["id"]
    }
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

   defp insert_or_update_user(changeset) do
    case Repo.get_by(User, providerUID: changeset.changes.providerUID) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end

end