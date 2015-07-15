Import sqlite

Function Main()
	Print "Opening database..."
	Local db := New SQLite3Database("foo.db")
	Print "Creating table..."
	If db.Exec("CREATE TABLE Test (Foo NUMBER, Bar TEXT)") <> SQLITE_OK Then Print "Error creating table."
	Print "Inserting rows..."
	If db.Exec("INSERT INTO Test (Foo, Bar) VALUES (100,'a')") <> SQLITE_OK Then Print "Error inserting row."
	If db.Exec("INSERT INTO Test (Foo, Bar) VALUES (200,'b')") <> SQLITE_OK Then Print "Error inserting row."
	If db.Exec("INSERT INTO Test (Foo) VALUES (300,'c')") <> SQLITE_OK Then Print "Error inserting row."
	If db.Exec("INSERT INTO Test (Foo) VALUES (400,'d')") <> SQLITE_OK Then Print "Error inserting row."
	
	Print "Testing prepared statement..."
	Local stmt := db.Prepare("SELECT * FROM Test WHERE Foo < ?")
	If Not stmt Then
		Print "Error preparing statement."
	Else
		stmt.BindInt(1, 250)
		While stmt.NextRow() <> SQLITE_DONE
			Print "Foo="+stmt.GetInt(0)
			Print "Bar="+stmt.GetString(1)
		End
		stmt.Finalize()
	End
	
	Print "Dropping table..."
	If db.Exec("DROP TABLE Test") <> SQLITE_OK Then Print "Error dropping table."
	Print "Closing database..."
	db.Close()
	Print "Finished."
End
