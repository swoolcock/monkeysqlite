# MonkeySQLite

SQLite3 bindings for the Monkey-X programming language.
http://www.monkey-x.com/

Simple example that creates a table, inserts some rows, and runs a query:
    Import sqlite
    
    Function Main()
        Local db := New SQLite3Database("foo.db")
        db.Exec("CREATE TABLE Test (Foo NUMBER)")
        db.Exec("INSERT INTO Test (Foo) VALUES (100)")
        db.Exec("INSERT INTO Test (Foo) VALUES (200)")
        db.Exec("INSERT INTO Test (Foo) VALUES (300)")
        db.Exec("INSERT INTO Test (Foo) VALUES (400)")
        Local stmt := db.Prepare("SELECT Foo FROM Test WHERE Foo < ?")
        stmt.BindInt(1, 250)
        While stmt.NextRow() <> SQLITE_DONE
            Print "Foo="+stmt.GetInt(0)
        End
        stmt.Finalize()
        db.Exec("DROP TABLE Test")
        db.Close()
    End
    
Prints:

    Foo=100
    Foo=200

Empty foo.db file will remain.
