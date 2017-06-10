defmodule Nextup.Web.AuthController do
  use Nextup.Web, :controller
  plug Ueberauth

  def signin(conn, params) do
    
  end

  def logout(conn, params) do
    
  end

  def callback(conn, params) do
    IO.inspect(conn)
    
  end

end