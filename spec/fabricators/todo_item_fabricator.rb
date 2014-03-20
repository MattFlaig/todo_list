Fabricator(:todo_item) do
  name { Faker::Lorem.words(1).join(" ") }
  content { Faker::Lorem.words(3).join(" ") }
  comment { Faker::Lorem.words(5).join(" ") }
  deadline { Date.today + rand(1..500).years }
  status 0
end
