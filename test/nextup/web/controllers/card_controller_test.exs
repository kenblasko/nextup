defmodule Nextup.Web.CardControllerTest do
  use Nextup.Web.ConnCase

  alias Nextup.Sets

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:card) do
    {:ok, card} = Sets.create_card(@create_attrs)
    card
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, card_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Cards"
  end

  test "renders form for new cards", %{conn: conn} do
    conn = get conn, card_path(conn, :new)
    assert html_response(conn, 200) =~ "New Card"
  end

  test "creates card and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == card_path(conn, :show, id)

    conn = get conn, card_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Card"
  end

  test "does not create card and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @invalid_attrs
    assert html_response(conn, 200) =~ "New Card"
  end

  test "renders form for editing chosen card", %{conn: conn} do
    card = fixture(:card)
    conn = get conn, card_path(conn, :edit, card)
    assert html_response(conn, 200) =~ "Edit Card"
  end

  test "updates chosen card and redirects when data is valid", %{conn: conn} do
    card = fixture(:card)
    conn = put conn, card_path(conn, :update, card), card: @update_attrs
    assert redirected_to(conn) == card_path(conn, :show, card)

    conn = get conn, card_path(conn, :show, card)
    assert html_response(conn, 200)
  end

  test "does not update chosen card and renders errors when data is invalid", %{conn: conn} do
    card = fixture(:card)
    conn = put conn, card_path(conn, :update, card), card: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Card"
  end

  test "deletes chosen card", %{conn: conn} do
    card = fixture(:card)
    conn = delete conn, card_path(conn, :delete, card)
    assert redirected_to(conn) == card_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, card_path(conn, :show, card)
    end
  end
end
