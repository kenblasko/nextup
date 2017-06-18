defmodule Nextup.Web.GroupController do
  use Nextup.Web, :controller

  alias Nextup.Sets

  def index(conn, _params) do
    groups = Sets.list_groups()
    render(conn, "index.html", groups: groups)
  end

  def new(%{assigns: %{user: user}} = conn, _params) do
    changeset = Sets.change_group(%Nextup.Sets.Group{})
    sets = Sets.list_sets_not_in_group(user)
    render(conn, "new.html", changeset: changeset, sets: sets, vendor: true)
  end

  def create(%{assigns: %{user: user}} = conn, %{"group" => group}) do
    case Sets.create_group(group, user) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: group_path(conn, :show, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        sets = Sets.list_sets_not_in_group(user)
        render(conn, "new.html", changeset: changeset, sets: sets, vendor: true)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Sets.get_group!(id)
    render(conn, "show.html", group: group)
  end

  def edit(conn, %{"id" => id}) do
    group = Sets.get_group!(id)
    changeset = Sets.change_group(group)
    sets = Sets.list_sets_not_in_group(group)
    render(conn, "edit.html", group: group, changeset: changeset, sets: sets, existing_sets: group.sets, vendor: true)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Sets.get_group!(id)

    case Sets.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: group_path(conn, :show, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Sets.get_group!(id)
    {:ok, _group} = Sets.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: group_path(conn, :index))
  end
end
