defmodule Nextup.Web.GroupControllerTest do
  use Nextup.Web.ConnCase

  alias Nextup.Sets

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:group) do
    {:ok, group} = Sets.create_group(@create_attrs)
    group
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, group_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Groups"
  end

  test "renders form for new groups", %{conn: conn} do
    conn = get conn, group_path(conn, :new)
    assert html_response(conn, 200) =~ "New Group"
  end

  test "creates group and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, group_path(conn, :create), group: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == group_path(conn, :show, id)

    conn = get conn, group_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Group"
  end

  test "does not create group and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, group_path(conn, :create), group: @invalid_attrs
    assert html_response(conn, 200) =~ "New Group"
  end

  test "renders form for editing chosen group", %{conn: conn} do
    group = fixture(:group)
    conn = get conn, group_path(conn, :edit, group)
    assert html_response(conn, 200) =~ "Edit Group"
  end

  test "updates chosen group and redirects when data is valid", %{conn: conn} do
    group = fixture(:group)
    conn = put conn, group_path(conn, :update, group), group: @update_attrs
    assert redirected_to(conn) == group_path(conn, :show, group)

    conn = get conn, group_path(conn, :show, group)
    assert html_response(conn, 200)
  end

  test "does not update chosen group and renders errors when data is invalid", %{conn: conn} do
    group = fixture(:group)
    conn = put conn, group_path(conn, :update, group), group: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Group"
  end

  test "deletes chosen group", %{conn: conn} do
    group = fixture(:group)
    conn = delete conn, group_path(conn, :delete, group)
    assert redirected_to(conn) == group_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, group_path(conn, :show, group)
    end
  end
end
