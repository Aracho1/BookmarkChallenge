class DatabaseConnection
<<<<<<< HEAD
  def self.setup(dbname)
    @connection = PG.connect(dbname)
  end

  def self.query(sql)
    @connection.exec(sql)
  end
=======

    def self.setup(dbname)
        @database_connection = PG.connect(dbname: dbname)
    end

    def self.query(qstring)
        @database_connection.exec(qstring)
    end
>>>>>>> b1ef3336d2f997e082d66391bfa23e6a9d0aea7b
end