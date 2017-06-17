defmodule Nextup.Web.Router do
  use Nextup.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Nextup.Web.Plugs.SetUser
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nextup.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sets", SetController
    resources "/cards", CardController
    resources "/groups", GroupController
    post "/cards/duplicate/:id", CardController, :duplicate
  end

  scope "/auth", Nextup.Web do
    pipe_through :browser

    get "/logout", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Nextup.Web do
  #   pipe_through :api
  # end
  
  defp put_user_token(conn, _) do
    if user = conn.assigns[:user] do
      token = Phoenix.Token.sign(conn, "user socket", user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

end
