defmodule CodingChallengeWeb.CurrencyConversionLive.Index do
  use CodingChallengeWeb, :live_view

  alias CodingChallenge.MoneyExchange
  alias CodingChallenge.MoneyExchange.CurrencyConversion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :currency_conversions, MoneyExchange.list_currency_conversions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Currency conversion")
    |> assign(:currency_conversion, MoneyExchange.get_currency_conversion!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Currency conversion")
    |> assign(:currency_conversion, %CurrencyConversion{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Currency conversions")
    |> assign(:currency_conversion, nil)
  end

  @impl true
  def handle_info({CodingChallengeWeb.CurrencyConversionLive.FormComponent, {:saved, currency_conversion}}, socket) do
    {:noreply, stream_insert(socket, :currency_conversions, currency_conversion)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    currency_conversion = MoneyExchange.get_currency_conversion!(id)
    {:ok, _} = MoneyExchange.delete_currency_conversion(currency_conversion)

    {:noreply, stream_delete(socket, :currency_conversions, currency_conversion)}
  end
end
