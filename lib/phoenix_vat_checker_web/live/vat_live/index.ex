defmodule PhoenixVatCheckerWeb.VatLive.Index do
  use PhoenixVatCheckerWeb, :live_view

  @invlid_format_error "The format of the VAT is not valid"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, error: nil, loading: false)}
  end

  def handle_event("suggest", %{"q" => query}, socket) do
    case VAT.valid_format?(query) do
      true ->
        {:noreply, assign(socket, query: query, error: nil, loading: true)}

      false ->
        {:noreply, assign(socket, query: query, error: @invlid_format_error, loading: true)}
    end
  end

  def handle_event("search", %{"q" => query}, socket) do
    case VAT.valid_format?(query) do
      true ->
        send(self(), {:search, query})
        {:noreply, assign(socket, query: query, error: nil, loading: true)}

      false ->
        {:noreply,
         assign(socket,
           query: query,
           result: nil,
           error: @invlid_format_error,
           loading: false
         )}
    end
  end

  def handle_info({:search, query}, socket) do
    case VAT.fetch(query) do
      {:error, error} ->
        {:noreply, assign(socket, query: query, result: nil, error: error, loading: false)}

      {:ok, result} ->
        {:noreply, assign(socket, query: query, result: result, error: nil, loading: false)}
    end
  end
end
