require 'pg'

def wipe_clean
    connection = PG.connect(dbname: 'bookmark_manager_test')

    result = connection.exec "TRUNCATE TABLE bookmarks"
    # result = connection.exec "CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, title VARCHAR(60), url VARCHAR(60))"
    # result = connection.exec "INSERT INTO bookmarks(title, url) VALUES('Makers', 'http://www.makersacademy.com')"
    # result = connection.exec "INSERT INTO bookmarks(title, url) VALUES('Destroy All Software', 'http://www.destroyallsoftware.com')"
    # result = connection.exec "INSERT INTO bookmarks(title, url) VALUES('Google', 'http://www.google.com')"
end

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
  result.first
end
