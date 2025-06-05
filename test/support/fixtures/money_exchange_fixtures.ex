defmodule CodingChallenge.MoneyExchangeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CodingChallenge.MoneyExchange` context.
  """

  @doc """
  Generate a currency_conversion.
  """
  def currency_conversion_fixture(attrs \\ %{}) do
    {:ok, currency_conversion} =
      attrs
      |> Enum.into(%{
        source_amount: 120.5,
        source_currency: "some source_currency",
        target_amount: 120.5,
        target_currency: "some target_currency"
      })
      |> CodingChallenge.MoneyExchange.create_currency_conversion()

    currency_conversion
  end
end
