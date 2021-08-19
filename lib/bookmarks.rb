require 'pg'

class Bookmarks

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end
    
    rs = con.exec('SELECT * FROM bookmarks')
    rs.map do |row| 
      Bookmarks.new(id: row['id'], title: row['title'], url: row['url'])
    end
  end

  def self.add(url, title)
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end
    
    # rs = con.exec "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title"
    
    result = con.exec_params(
      # The first argument is our SQL query template
      # The second argument is the 'params' referred to in exec_params
      # $1 refers to the first item in the params array
      # $2 refers to the second item in the params array
      "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title]
    )
    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end
end
