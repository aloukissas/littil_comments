defmodule LittilCommentsWeb.CommentsChannel do
  use LittilCommentsWeb, :channel
  alias LittilComments.Comments

  @impl true
  def join("comments:" <> path, %{"host" => host}, socket) do
    socket = assign(socket, :host, host)

    case Comments.list_comments_by_host_and_path(host, path) do
      [] ->
        {:ok, socket}

      comments ->
        {:ok, socket, %{comments: comments}}
    end
  end

  @impl true
  def handle_in("add_comment", %{"text" => text}, socket) when is_binary(text) do
    case Comments.create_comment(%{host: socket.assigns.host, path: socket.topic, text: text}) do
      {:ok, comment} ->
        broadcast(socket, "comment_added", %{comment: comment})

      {:error, changeset} ->
        broadcast(socket, "comment_error", %{errors: changeset.errors})
    end

    {:noreply, socket}
  end
end
