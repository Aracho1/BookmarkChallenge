require './lib/database_connection'

describe DatabaseConnection do
    
  describe '# database_connection.setup' do
    it 'should set up a connection to the database' do
        expect(PG).to receive(:connect).with(dbname:'bookmark_manager_test')
        DatabaseConnection.setup('bookmark_manager_test')
    end
  end

  describe '.query' do
    it 'should execute an SQL query string on DB' do
        connection = DatabaseConnection.setup('bookmark_manager_test')
        expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")

        DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
      
  end



end