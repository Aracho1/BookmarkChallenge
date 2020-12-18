class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname)
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end