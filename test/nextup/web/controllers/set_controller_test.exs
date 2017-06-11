defmodule Nextup.Web.SetControllerTest do
  use Nextup.Web.ConnCase

  alias Nextup.Sets

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:set) do
    {:ok, set} = Sets.create_set(@create_attrs)
    set
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, set_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Sets"
  end

  test "renders form for new sets", %{conn: conn} do
    conn = get conn, set_path(conn, :new)
    assert html_response(conn, 200) =~ "New Set"
  end

  test "creates set and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, set_path(conn, :create), set: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == set_path(conn, :show, id)

    conn = get conn, set_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Set"
  end

  test "does not create set and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, set_path(conn, :create), set: @invalid_attrs
    assert html_response(conn, 200) =~ "New Set"
  end

  test "renders form for editing chosen set", %{conn: conn} do
    set = fixture(:set)
    conn = get conn, set_path(conn, :edit, set)
    assert html_response(conn, 200) =~ "Edit Set"
  end

  test "updates chosen set and redirects when data is valid", %{conn: conn} do
    set = fixture(:set)
    conn = put conn, set_path(conn, :update, set), set: @update_attrs
    assert redirected_to(conn) == set_path(conn, :show, set)

    conn = get conn, set_path(conn, :show, set)
    assert html_response(conn, 200)
  end

  test "does not update chosen set and renders errors when data is invalid", %{conn: conn} do
    set = fixture(:set)
    conn = put conn, set_path(conn, :update, set), set: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Set"
  end

  test "deletes chosen set", %{conn: conn} do
    set = fixture(:set)
    conn = delete conn, set_path(conn, :delete, set)
    assert redirected_to(conn) == set_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, set_path(conn, :show, set)
    end
  end
end
