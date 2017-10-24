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

  def home_phone(unclean)
    clean_number =  unclean.to_s.scan(/\d/).join
    if clean_number.length >= 10
      "(#{clean_number[0..2]}) #{clean_number[3..5]}-#{clean_number[6..9]}"

    elsif clean_number.length > 0
      clean_number = nil

    else
      clean_number
    end
  end
end
