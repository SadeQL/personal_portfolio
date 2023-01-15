defmodule PersonalPortfolioWeb.PageController do
  use PersonalPortfolioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
