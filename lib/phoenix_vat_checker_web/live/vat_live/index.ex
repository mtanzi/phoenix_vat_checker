defmodule PhoenixVatCheckerWeb.VatLive.Index do
  use PhoenixVatCheckerWeb, :live_view

  alias ExVatcheck.VAT

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, valid: false, loading: false)}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do
    case ExVatcheck.Countries.valid_format?(query) do
      true ->
        {:noreply, assign(socket, query: query, valid: true, loading: true)}

      false ->
        {:noreply, assign(socket, query: query, valid: false, loading: true)}
    end
  end
end
