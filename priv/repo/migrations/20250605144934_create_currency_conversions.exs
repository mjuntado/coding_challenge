defmodule CodingChallenge.Repo.Migrations.CreateCurrencyConversions do
  use Ecto.Migration

  def change do
    create table(:currency_conversions) do
      add :source_currency, :string
      add :target_currency, :string
      add :source_amount, :float
      add :target_amount, :float

      timestamps(type: :utc_datetime)
    end
  end
end
