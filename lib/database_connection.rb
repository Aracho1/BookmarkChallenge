class DatabaseConnection

    def self.setup(dbname)
        @database_connection = PG.connect(dbname: dbname)
    end

    def self.query(qstring)
        @database_connection.exec(qstring)
    end
end