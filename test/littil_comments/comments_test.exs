defmodule LittilComments.CommentsTest do
  use LittilComments.DataCase

  alias LittilComments.Comments

  describe "comments" do
    alias LittilComments.Comments.Comment

    import LittilComments.CommentsFixtures

    @invalid_attrs %{host: nil, path: nil, text: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Comments.list_comments() == [comment]
    end

    test "list_comments_by_host_and_path/2 returns all comments for a given host and path" do
      host = "example.com"
      path = "/foo"

      comment_one = comment_fixture(%{host: host, path: path, test: "some text"})

      comment_two =
        comment_fixture_with_date(
          %{host: host, path: path, test: "some other text"},
          NaiveDateTime.add(comment_one.inserted_at, 1, :second)
        )

      assert Comments.list_comments_by_host_and_path(host, path) == [comment_two, comment_one]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{host: "some host", path: "some path", text: "some text"}

      assert {:ok, %Comment{} = comment} = Comments.create_comment(valid_attrs)
      assert comment.host == "some host"
      assert comment.path == "some path"
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()

      update_attrs = %{
        host: "some updated host",
        path: "some updated path",
        text: "some updated text"
      }

      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, update_attrs)
      assert comment.host == "some updated host"
      assert comment.path == "some updated path"
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
