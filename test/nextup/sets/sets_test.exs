defmodule Nextup.SetsTest do
  use Nextup.DataCase

  alias Nextup.Sets

  describe "cards" do
    alias Nextup.Sets.Card

    @valid_attrs %{content: "some content", title: "some title"}
    @update_attrs %{content: "some updated content", title: "some updated title"}
    @invalid_attrs %{content: nil, title: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sets.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Sets.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Sets.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Sets.create_card(@valid_attrs)
      assert card.content == "some content"
      assert card.title == "some title"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sets.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, card} = Sets.update_card(card, @update_attrs)
      assert %Card{} = card
      assert card.content == "some updated content"
      assert card.title == "some updated title"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Sets.update_card(card, @invalid_attrs)
      assert card == Sets.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Sets.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Sets.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Sets.change_card(card)
    end
  end

  describe "sets" do
    alias Nextup.Sets.Set

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def set_fixture(attrs \\ %{}) do
      {:ok, set} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sets.create_set()

      set
    end

    test "list_sets/0 returns all sets" do
      set = set_fixture()
      assert Sets.list_sets() == [set]
    end

    test "get_set!/1 returns the set with given id" do
      set = set_fixture()
      assert Sets.get_set!(set.id) == set
    end

    test "create_set/1 with valid data creates a set" do
      assert {:ok, %Set{} = set} = Sets.create_set(@valid_attrs)
      assert set.description == "some description"
      assert set.title == "some title"
    end

    test "create_set/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sets.create_set(@invalid_attrs)
    end

    test "update_set/2 with valid data updates the set" do
      set = set_fixture()
      assert {:ok, set} = Sets.update_set(set, @update_attrs)
      assert %Set{} = set
      assert set.description == "some updated description"
      assert set.title == "some updated title"
    end

    test "update_set/2 with invalid data returns error changeset" do
      set = set_fixture()
      assert {:error, %Ecto.Changeset{}} = Sets.update_set(set, @invalid_attrs)
      assert set == Sets.get_set!(set.id)
    end

    test "delete_set/1 deletes the set" do
      set = set_fixture()
      assert {:ok, %Set{}} = Sets.delete_set(set)
      assert_raise Ecto.NoResultsError, fn -> Sets.get_set!(set.id) end
    end

    test "change_set/1 returns a set changeset" do
      set = set_fixture()
      assert %Ecto.Changeset{} = Sets.change_set(set)
    end
  end
end
