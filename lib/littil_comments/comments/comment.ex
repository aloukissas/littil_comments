defmodule LittilComments.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :host, :string
    field :path, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :host, :path])
    |> validate_required([:text, :host, :path])
  end
end
