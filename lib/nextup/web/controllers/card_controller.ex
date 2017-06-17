defmodule Nextup.Web.CardController do
  use Nextup.Web, :controller

  alias Nextup.Sets
  alias Nextup.Sets.Card

  plug Nextup.Web.Plugs.RequireAuth when action in [
    :new, :create, :edit, :update, :delete
  ]

  plug :check_card_owner when action in [
    :edit, :update, :delete
  ]

  def index(conn, _params) do
    cards = Sets.list_cards
    render(conn, "index.html", cards: cards)
  end

  def new(conn, _params) do
    changeset = Sets.change_card(%Card{})
    render(conn, "new.html", changeset: changeset, vendor: true)
  end

  def create(%{assigns: %{user: user}} = conn, %{"card" => card}) do
    case Sets.create_card(card, user) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: card_path(conn, :show, card))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, vendor: true)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    changeset = Sets.change_card(card)
    render(conn, "edit.html", card: card, changeset: changeset, vendor: true)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Sets.get_card!(id)

    case Sets.update_card(card, card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: card_path(conn, :show, card))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    {:ok, _card} = Sets.delete_card(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: card_path(conn, :index))
  end

  defp check_card_owner(%{params: %{"id" => id}} = conn, _params) do
    if Sets.get_card!(id).user_id == conn.assigns.user.id do
      conn
    else
       conn
        |> put_flash(:error, "Not Authorized")
        |> redirect(to: card_path(conn, :index))
        |> halt()
    end
  end

  def duplicate(%{assigns: %{user: user}} = conn, %{"id" => id}) do
    card = Sets.get_card!(id) 
    case Sets.create_card(%{"title": card.title, "body": card.body}, user) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card duplicated successfully.")
        |> redirect(to: card_path(conn, :edit, card))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset, vendor: true)
    end
  end

end
