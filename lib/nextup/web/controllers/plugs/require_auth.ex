defmodule Nextup.Web.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Nextup.Web.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn 
      |> put_flash(:error, "Not Authorized")
      |> redirect(to: Helpers.set_path(conn, :index))
      |> halt()
    end
  end

end