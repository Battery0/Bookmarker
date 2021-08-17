require 'pg'

def setup_test_database
  con = PG.connect :dbname => 'bookmark_manager_test'
  con.exec "TRUNCATE TABLE bookmarks"
  Bookmarks.add('http://www.makersacademy.com/')
  Bookmarks.add('http://www.google.com/')
  Bookmarks.add('http://www.destroyallsoftware.com')
end