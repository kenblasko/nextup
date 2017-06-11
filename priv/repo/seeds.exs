defmodule Nextup.DatabaseSeeder do
  alias Nextup.Repo
  alias Nextup.Sets.Card

  @titles_list [
    "Warrior", 
    "Rogue", 
    "Sorcerer"
  ]
  @content_list [
    "Etiam porta sem malesuada magna mollis euismod. Aenean lacinia bibendum nulla sed consectetur. Curabitur blandit tempus porttitor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.", 
    "Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras mattis consectetur purus sit amet fermentum. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.", 
    "Nullam id dolor id nibh ultricies vehicula ut id elit. Vestibulum id ligula porta felis euismod semper. Curabitur blandit tempus porttitor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."
  ]

  def insert_card do
    Repo.insert! %Card{
      title: @titles_list |> Enum.take_random(1) |> hd,
      body: @content_list |> Enum.take_random(1) |> hd,
      user_id: 1
    }
  end

  def clear do
    Repo.delete_all
  end

end

(1..20) |> Enum.each(fn _ -> Nextup.DatabaseSeeder.insert_card end)