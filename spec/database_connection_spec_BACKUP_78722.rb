<<<<<<< HEAD
require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up the database' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
      DatabaseConnection.setup(dbname: 'bookmark_manager_test')
=======
require './lib/database_connection'

describe DatabaseConnection do
    
  describe '# database_connection.setup' do
    it 'should set up a connection to the database' do
        expect(PG).to receive(:connect).with(dbname:'bookmark_manager_test')
        DatabaseConnection.setup('bookmark_manager_test')
>>>>>>> b1ef3336d2f997e082d66391bfa23e6a9d0aea7b
    end
  end

  describe '.query' do
<<<<<<< HEAD
    it 'queries the database' do
      connection = DatabaseConnection.setup(dbname: 'bookmark_manager_test')
      expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")
      DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
  end
=======
    it 'should execute an SQL query string on DB' do
        connection = DatabaseConnection.setup('bookmark_manager_test')
        expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")

        DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
      
  end



>>>>>>> b1ef3336d2f997e082d66391bfa23e6a9d0aea7b
end