defmodule Nextup.Web.CardChannel do
  use Nextup.Web, :channel

  alias Nextup.Sets

  def join("card:" <> _id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("card_saved", payload, socket) do
    save_card(socket, payload)
    {:reply, {:ok, payload}, socket}
  end

  defp save_card(%{assigns: %{card: card_id}} = socket, payload) do
    card = Sets.get_card_without_preload!(card_id)
    case Sets.update_card(card, payload) do
      {:ok, _card} -> broadcast! socket, "card_saved", payload
      {:error, _changeset} -> socket
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end
