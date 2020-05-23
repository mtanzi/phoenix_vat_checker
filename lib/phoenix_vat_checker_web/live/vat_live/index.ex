defmodule PhoenixVatCheckerWeb.VatLive.Index do
  use PhoenixVatCheckerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, valid: false, loading: false)}
  end
end
