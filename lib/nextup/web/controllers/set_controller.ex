defmodule Nextup.Web.SetController do
  use Nextup.Web, :controller

  alias Nextup.Sets


  plug Nextup.Web.Plugs.RequireAuth when action in [
    :new, :create, :edit, :update, :delete
  ]

  plug :check_set_owner when action in [
    :edit, :update, :delete
  ]

  def index(conn, _params) do
    sets = Sets.list_sets()
    render(conn, "index.html", sets: sets)
  end

  def new(conn, _params) do
    changeset = Sets.change_set(%Nextup.Sets.Set{})
    cards = Sets.list_cards()
    render(conn, "new.html", changeset: changeset, cards: cards, vendor: true)
  end

  def create(%{assigns: %{user: user}} = conn, %{"set" => set}) do
    case Sets.create_set(set, user) do
      {:ok, set} ->
        conn
        |> put_flash(:info, "Set created successfully.")
        |> redirect(to: set_path(conn, :show, set))
      {:error, %Ecto.Changeset{} = changeset} ->
        cards = Sets.list_cards()
        render(conn, "new.html", changeset: changeset, cards: cards, vendor: true)
    end
    conn
  end

  def show(conn, %{"id" => id}) do
    set = Sets.get_set!(id)
    sorted_cards = Sets.sort_cards(set)
    render(conn, "show.html", set: set, sorted_cards: sorted_cards)
  end

  def edit(conn, %{"id" => id}) do
    set = Sets.get_set!(id)
    changeset = Sets.change_set(set)
    cards = Sets.cards_not_in(set)
    sorted_cards = Sets.sort_cards(set)
    render(conn, "edit.html", set: set, changeset: changeset, cards: cards, sorted_cards: sorted_cards, vendor: true)
  end

  def update(conn, %{"id" => id, "set" => set_params} = params) do
    set = Sets.get_set!(id)
    case Sets.update_set(set, set_params) do
      {:ok, set} ->
        conn
        |> put_flash(:info, "Set updated successfully.")
        |> redirect(to: set_path(conn, :show, set))
      {:error, %Ecto.Changeset{} = changeset} ->
        cards = Sets.cards_not_in(set)
        sorted_cards = Sets.sort_cards(set)
        render(conn, "edit.html", set: set, changeset: changeset, cards: cards, sorted_cards: sorted_cards, vendor: true)
    end
  end

  def delete(conn, %{"id" => id}) do
    set = Sets.get_set!(id)
    {:ok, _set} = Sets.delete_set(set)

    conn
    |> put_flash(:info, "Set deleted successfully.")
    |> redirect(to: set_path(conn, :index))
  end

  def check_set_owner(%{params: %{"id" => id}} = conn, _params) do
    if Sets.get_set!(id).user_id == conn.assigns.user.id do
      conn
    else
      conn
        |> put_flash(:error, "Not Authorized")
        |> redirect(to: card_path(conn, :index))
        |> halt()
    end
  end
end
