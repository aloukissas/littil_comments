defmodule LittilComments.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias LittilComments.Repo

  alias LittilComments.Comments.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Returns the list of comments for a given host and path.

  ## Examples

      iex> list_comments_by_host_and_path("example.com", "/foo")
      [%Comment{}, ...]

  """
  def list_comments_by_host_and_path(host, path, limit \\ 10) do
    Repo.all(
      from c in Comment,
        where: c.host == ^host and c.path == ^path,
        order_by: [desc: c.inserted_at],
        limit: ^limit
    )
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a comment with a given date.

  ## Examples

      iex> create_comment_with_date(%{field: value}, DateTime.utc_now())
      {:ok, %Comment{}}

      iex> create_comment_with_date(%{field: bad_value}, DateTime.utc_now())
      {:error, %Ecto.Changeset{}}

  """
  def create_comment_with_date(attrs, date) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Ecto.Changeset.put_change(:inserted_at, date)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
