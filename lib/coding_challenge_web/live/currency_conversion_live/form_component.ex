defmodule CodingChallengeWeb.CurrencyConversionLive.FormComponent do
  use CodingChallengeWeb, :live_component

  alias CodingChallenge.MoneyExchange

  @api_url "https://open.er-api.com/v6/latest/"

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage currency_conversion records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="currency_conversion-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:source_currency]} type="select" options={@options} label="Source currency" />
        <.input field={@form[:target_currency]} type="select" options={@options} label="Target currency" />
        <.input field={@form[:source_amount]} type="number" label="Source amount" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Currency conversion</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{currency_conversion: currency_conversion} = assigns, socket) do
    options =
      # get default options using usd
      with {:ok, %{body: body}} <- HTTPoison.get(@api_url <> "USD"),
           {:ok, body} <- Jason.decode(body) do
        body
        |> Map.get("rates")
        |> Map.keys()
      else
        _ ->
          []
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:options, options)
     |> assign_new(:form, fn ->
       to_form(MoneyExchange.change_currency_conversion(currency_conversion))
     end)}
  end

  @impl true
  def handle_event("validate", %{"currency_conversion" => currency_conversion_params}, socket) do
    changeset = MoneyExchange.change_currency_conversion(socket.assigns.currency_conversion, currency_conversion_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"currency_conversion" => currency_conversion_params}, socket) do
    save_currency_conversion(socket, socket.assigns.action, currency_conversion_params)
  end

  defp save_currency_conversion(socket, :edit, currency_conversion_params) do
    target_amount = calculate_target_amount(currency_conversion_params)
    currency_conversion_params = Map.put(currency_conversion_params, "target_amount", target_amount)

    case MoneyExchange.update_currency_conversion(socket.assigns.currency_conversion, currency_conversion_params) do
      {:ok, currency_conversion} ->
        notify_parent({:saved, currency_conversion})

        {:noreply,
         socket
         |> put_flash(:info, "Currency conversion updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_currency_conversion(socket, :new, currency_conversion_params) do
    target_amount = calculate_target_amount(currency_conversion_params)
    currency_conversion_params = Map.put(currency_conversion_params, "target_amount", target_amount)

    case MoneyExchange.create_currency_conversion(currency_conversion_params) do
      {:ok, currency_conversion} ->
        notify_parent({:saved, currency_conversion})

        {:noreply,
         socket
         |> put_flash(:info, "Currency conversion created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp calculate_target_amount(%{"source_currency" => source_currency, "source_amount" => source_amount, "target_currency" => target_currency}) do
    with {:ok, %{body: body}} <- HTTPoison.get(@api_url <> source_currency),
         {:ok, body} <- Jason.decode(body) do
      rates = body["rates"] || %{}
      target_rate = rates[target_currency] || 0.0

      {source_amount, _} = Float.parse(source_amount)

      Float.round(source_amount * target_rate, 2)
    else
      _ -> 0.0
    end
  end
end
