/*
Copyright (c) 2015 Shane Woolcock

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgement in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*/

#include "sqlite3.h"

class ExtSQLite3Callback;
class ExtSQLite3Database;
class ExtSQLite3Statement;

class ExtSQLite3Callback : public Object
{
/*public:
	int _columnCount;
	Array<String> _columnValues;
	Array<String> _columnNames;
	// Method Callback:Void(columnCount:Int, columnValues:String[], columnNames:String[])
	virtual int Callback(int columnCount, Array<String> columnValues, Array<String> columnNames)=0;*/
};

/*int callbackFunc(void *ptr, int columnCount, char **columnValues, char **columnNames)
{
	SQLite3Callback *cb = dynamic_cast<SQLite3Callback *>(ptr);
	if(cb == NULL) return 0;

	Array<String> valuesArray = new Array<String>(columnCount);
	Array<String> namesArray = new Array<String>(columnCount);
	for(int i=0; i<columnCount; i++)
	{
		valuesArray[i] = columnValues[i];
		namesArray[i] = columnNames[i];
	}
	cb->Callback(columnCount, columnValues, columnNames);
}*/

class ExtSQLite3Database : public Object
{
protected:
	int Init(String filename, int flags, String vfs)
	{
		int result = 0;
		if (flags == -1) {
			result = sqlite3_open(filename.ToCString<char>(), &_db);
		}
		else if (vfs.Length()==0) {
			result = sqlite3_open_v2(filename.ToCString<char>(), &_db, flags, NULL);
		}
		else {
			result = sqlite3_open_v2(filename.ToCString<char>(), &_db, flags, vfs.ToCString<char>());
		}
		return result;
	}

public:
	sqlite3 *_db;
	int _flags;
	bool _closed;

	// internal
	ExtSQLite3Database() : _db(NULL), _flags(-1), _closed(false) {}
	ExtSQLite3Database(sqlite3 *db) : _db(db), _flags(-1), _closed(false) {}
	~ExtSQLite3Database()
	{
		// make sure the database is closed
		int result = 0;
		if(!_closed)
			sqlite3_close_v2(_db);
		// TODO: something with result
	}
	
	/////// Common Methods ///////

	// Method Close:Int()
	int Close()
	{
		if(_closed) return 0;
		_closed = true;
		return sqlite3_close_v2(_db);
	}

	// Method Prepare:ExtSQLite3Statement(sql:String)
	virtual ExtSQLite3Statement *Prepare(String sql)=0;

	// Method Exec:Int(sql:String, callback:SQLite3Callback=Null)
	int Exec(String sql, ExtSQLite3Callback *callback)
	{
		return sqlite3_exec(_db, sql.ToCString<char>(), NULL, NULL, NULL);
	}
};

class ExtSQLite3Statement : public Object
{
protected:
	int Init(ExtSQLite3Database *db, String sql)
	{
		return sqlite3_prepare_v2(db->_db, sql.ToCString<char>(), -1, &_stmt, NULL);
	}

public:
	bool _finalized;
	sqlite3_stmt *_stmt;

	ExtSQLite3Statement() : _stmt(NULL), _finalized(false) {}

	~ExtSQLite3Statement()
	{
		// make sure the statement is finalized
		int result = 0;
		if(!_finalized)
			sqlite3_finalize(_stmt);
		// TODO: something with result
	}

	// Method Finalize:Void()
	int Finalize()
	{
		if(_finalized) return 0;
		_finalized = true;
		return sqlite3_finalize(_stmt);
	}

	// Method BindFloat:Int(index:Int, value:Float)
	int BindFloat(int index, float value)
	{
		return sqlite3_bind_double(_stmt, index, (double)value);
	}

	// Method BindInt:Int(index:Int, value:Int)
	int BindInt(int index, int value)
	{
		return sqlite3_bind_int(_stmt, index, value);
	}

	// Method BindString:Int(index:Int, value:String)
	int BindString(int index, String value)
	{
		return sqlite3_bind_text(_stmt, index, value.ToCString<char>(), -1, SQLITE_TRANSIENT);
	}

	// Method BindNull:Int(index:Int)
	int BindNull(int index)
	{
		return sqlite3_bind_null(_stmt, index);
	}

	// Method NextRow:Int()
	int NextRow()
	{
		return sqlite3_step(_stmt);
	}

	// Method GetFloat:Float(index:Int)
	float GetFloat(int index)
	{
		return (float)sqlite3_column_double(_stmt, index);
	}

	// Method GetInt:Int(index:Int)
	int GetInt(int index)
	{
		return sqlite3_column_int(_stmt, index);
	}

	// Method GetString:String(index:Int)
	String GetString(int index)
	{
		const unsigned char *val = sqlite3_column_text(_stmt, index);
		if(val==NULL) return String("");
		return String(val);
	}

	// Method GetType:Int(index:Int)
	int GetType(int index)
	{
		return sqlite3_column_type(_stmt, index);
	}
};
