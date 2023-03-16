defmodule LittilComments.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LittilComments.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        host: "example.com",
        path: "/about",
        text: "some text"
      })
      |> LittilComments.Comments.create_comment()

    comment
  end

  def comment_fixture_with_date(attrs, date) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        host: "example.com",
        path: "/about",
        text: "some text"
      })
      |> LittilComments.Comments.create_comment_with_date(date)

    comment
  end
end
