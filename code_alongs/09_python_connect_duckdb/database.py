import duckdb
from constants import DATABASE_PATH

# Implements context manager protocol
class Database:
    def __init__(self, db_path) -> None:
        self.db_path = db_path
        self.connection = None
    
    def __enter__(self):
        #print("Enters Database")
        # Connect to the database
        self.connection = duckdb.connect(self.db_path)
        return self

    def query(self, query):
        return self.connection.execute(query).fetchall()

    def __exit__(self, exc_type, exc_value, traceback):
        #print("Exits Database")
        # Close the connection
        if self.connection:
            self.connection.close()


class DatabaseDataFrame(Database):
    def query(self, query):
        return self.connection.execute(query).df()

if __name__ == "__main__":
    with DatabaseDataFrame(DATABASE_PATH) as db:
        # queries
        query1 = db.query("SELECT * FROM information_schema.schemata;")
        print(query1)
        