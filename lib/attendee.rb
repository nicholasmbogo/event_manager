class Attendee

  attr_reader :id,
              :regdate,
              :first_name,
              :last_name,
              :email_address,
              :homephone,
              :street,
              :city,
              :state,
              :zipcode

  def initialize(data)
    @id = data[:_]
    @regdate = data[:regdate]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email_address = data[:email_address]
    @homephone = data[:homephone]
    @street = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = data[:zipcode]

  end
end
