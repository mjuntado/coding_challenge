defmodule CodingChallenge.MoneyExchange.CurrencyConversion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency_conversions" do
    field :source_currency, :string
    field :target_currency, :string
    field :source_amount, :float
    field :target_amount, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(currency_conversion, attrs) do
    currency_conversion
    |> cast(attrs, [:source_currency, :target_currency, :source_amount, :target_amount])
    |> validate_required([:source_currency, :target_currency, :source_amount])
  end
end
