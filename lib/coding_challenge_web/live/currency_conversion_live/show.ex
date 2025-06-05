defmodule CodingChallengeWeb.CurrencyConversionLive.Show do
  use CodingChallengeWeb, :live_view

  alias CodingChallenge.MoneyExchange

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:currency_conversion, MoneyExchange.get_currency_conversion!(id))}
  end

  defp page_title(:show), do: "Show Currency conversion"
  defp page_title(:edit), do: "Edit Currency conversion"
end
