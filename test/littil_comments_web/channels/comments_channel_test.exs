defmodule LittilCommentsWeb.CommentsChannelTest do
  use LittilCommentsWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      LittilCommentsWeb.UserSocket
      |> socket("user_id", %{host: "example.com"})
      |> subscribe_and_join(LittilCommentsWeb.CommentsChannel, "comments:/test/path", %{
        "host" => "example.com"
      })

    %{socket: socket}
  end

  test "shout broadcasts to comments:lobby", %{socket: socket} do
    push(socket, "add_comment", %{"text" => "hello"})
    assert_broadcast "comment_added", %{comment: %{text: "hello"}}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
