defmodule Nextup.Web.PageController do
  use Nextup.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
