defmodule CodingChallengeWeb.PageController do
  use CodingChallengeWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    redirect(conn, to: ~p"/currency_conversions")
  end
end
