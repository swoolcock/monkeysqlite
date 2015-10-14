/*
MonkeySQLite: Released under zlib license (https://en.wikipedia.org/wiki/Zlib_License)
SQLite: Released to public domain (https://www.sqlite.org/copyright.html)

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

import android.database.*;
import android.database.sqlite.*;

class ExtSQLite3Database {
	SQLiteDatabase db;
	
	int _Init(String filename, int flags, String vfs)
	{
		db = SQLiteDatabase.openOrCreateDatabase(filename, null);
		return 1;
	}

	// Method Exec:Int(sql:String)
	int _Exec(String sql)
	{
		db.execSQL(sql);
		return 1;
	}

	// Method Close:Int()
	int _Close()
	{
		if(db!=null && !db.isClosed()) {
			db.close();
			db = null;
		}
		return 1;
	}
}

/**
 * Android's implementation of SQLite does not use the traditional form
 * of prepared statements.  In Android, a prepared statement cannot return
 * a cursor.  Instead we need to pass all the bound variables to an execute call.
 */
class ExtSQLite3Statement {
	ExtSQLite3Database db;
	String sql;
	Map<Integer, Object> bindings = new HashMap<Integer, Object>();
	Map<Integer, Class<?>> classes = new HashMap<Integer, Class<?>>();
	int maxIndex = 0;
	Cursor cursor;
	
	int _Init(ExtSQLite3Database db, String sql)
	{
		this.db = db;
		this.sql = sql;
		return 1;
	}

	// Method Finalize:Void()
	int _Finalize()
	{
		if(cursor!=null) {
			// TODO: close cursor
		}
		return 1;
	}

	// Method BindFloat:Int(index:Int, value:Float)
	int _BindFloat(int index, float value)
	{
		maxIndex = index > maxIndex ? index : maxIndex;
		bindings.put(index, Float.valueOf(value));
		classes.put(index, Float.TYPE);
		return 1;
	}

	// Method BindInt:Int(index:Int, value:Int)
	int _BindInt(int index, int value)
	{
		maxIndex = index > maxIndex ? index : maxIndex;
		bindings.put(index, Integer.valueOf(value));
		classes.put(index, Integer.TYPE);
		return 1;
	}

	// Method BindString:Int(index:Int, value:String)
	int _BindString(int index, String value)
	{
		maxIndex = index > maxIndex ? index : maxIndex;
		bindings.put(index, value);
		classes.put(index, String.class);
		return 1;
	}

	// Method BindNull:Int(index:Int)
	int _BindNull(int index)
	{
		maxIndex = index > maxIndex ? index : maxIndex;
		bindings.clear(index);
		classes.put(index, Void.TYPE);
		return 1;
	}

	// Method NextRow:Int()
	int _NextRow()
	{
		if(cursor==null) {
			String[] args = new String[maxIndex];
			for(int index : classes.keySet()) {
				Class<?> clazz = classes.get(index);
				if(clazz==Void.TYPE) {
					args[index-1] = null;
				} else {
					args[index-1] = bindings.get(index).toString();
				}
			}
			cursor = db.db.rawQuery(sql, args);
		}
		if(cursor==null) {
			// error
			return 0;
		}
		return cursor.moveToNext() ? 1 : 0;
	}

	// Method GetFloat:Float(index:Int)
	float _GetFloat(int index)
	{
		return cursor.isNull(index-1) ? 0 : cursor.getFloat(index-1);
	}

	// Method GetInt:Int(index:Int)
	int _GetInt(int index)
	{
		return cursor.isNull(index-1) ? 0 : cursor.getInt(index-1);
	}

	// Method GetString:String(index:Int)
	String _GetString(int index)
	{
		return cursor.isNull(index-1) ? "" : cursor.getString(index-1);
	}

	// Method GetType:Int(index:Int)
	int _GetType(int index)
	{
		return cursor.getType(index-1);
	}
}
