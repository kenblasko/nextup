defmodule Nextup.Web.Router do
  use Nextup.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Nextup.Web.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nextup.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sets", SetController
    resources "/cards", CardController
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
end
