0.upto(29) do |idx|
    Member.create(
        number: idx + 20,
        name: "John#{idx}",
        full_name: "John Doe#{idx + 1}",
        email: "john#{idx + 1}@example.com",
        birthday: "1981-12-01",
        sex: 1,
        administrator: (idx == 0),
        password: "asagao",
        password_confirmation: "asagao"
    )
end