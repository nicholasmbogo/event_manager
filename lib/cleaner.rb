require 'csv'
class Cleaner
   def clean_zipcode(zipcode)
       if zipcode.nil?
         zipcode = "00000"

       elsif zipcode.length < 5
         zipcode = zipcode.rjust(5, "0")

       elsif zipcode.length > 5
         zipcode = zipcode[0..4]

       else
         zipcode
       end

  end
end
