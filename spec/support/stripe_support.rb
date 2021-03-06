def valid_card_data
  exp_date = 3.months.from_now
  {
    number:      '4242424242424242',
    cvc:         '123',
    address_zip: '12312',
    exp_month:   exp_date.month,
    exp_year:    exp_date.year
  }
end

def load_webhook_json webhook_name
  path = Rails.root.join *%W[ spec data stripe #{ webhook_name }.json ]
  json = File.open(path).read
  JSON.parse json
end
