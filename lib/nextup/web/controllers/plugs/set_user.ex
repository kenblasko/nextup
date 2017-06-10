defmodule Nextup.Web.Plugs.SetUser do
  import Plug.Conn

  alias Nextup.Repo
  alias Nextup.Admin.User

  def init(_params) do
  end

  def call(conn, _params) do
    id = get_session(conn, :user_id)    

    cond do
      user = id && Repo.get(User, id) -> assign(conn, :user, user)
      true -> assign(conn, :user, nil)
    end
  end

end    