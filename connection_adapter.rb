class ConnectionAdapter
  def find(id, table)
    rows = execute("select * from #{table} where id = #{id} limit 1")
    columns = columns(table)
    
    map_columns_to_values columns, rows.first
  end
  
  def find_all(table)
    rows = execute("select * from #{table}")
    columns = columns(table)
    
    rows.map { |row| map_columns_to_values columns, row }
  end
  
  def columns(table)
    table_info(table).map { |info| info["name"].to_sym }
  end
  
  def map_columns_to_values(columns, values)
    Hash[columns.zip(values)]
  end
end

class SqliteAdapter < ConnectionAdapter
  def initialize
    require "sqlite3"
    @db = SQLite3::Database.new(File.dirname(__FILE__) + "/db/app.db")
  end
  
  def execute(sql)
    @db.execute(sql)
  end
  
  def table_info(table)
    @db.table_info(table)
  end
end

class MysqlAdapter < ConnectionAdapter
  
end