require 'json'
require 'airtable'
require 'active_support/all'
require 'dotenv'
Dotenv.load('.env')

AIRTABLE_APP = ENV["AIRTABLE_BASE_UID"]

# Pass in api key to client
@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])

# Pass in the app key and table name

@table = @client.table(AIRTABLE_APP, "artists")
@records = @table.select(view: "Grid view")

# Change the filename here below but make sure it's in the _data folder.
File.open("_data/artists.json", "w") do |f|
    data = @records.map { |record| record.attributes }
    f.write(data.to_json)
end