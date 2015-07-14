#Rem
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
#End

Strict

Public

' import extern wrapper
Import "native/externs.${LANG}"

Private Extern
Class ExtSQLite3Callback
End

Class ExtSQLite3Database
Protected
	Method Init:Int(filename:String, flags:Int=-1, vfs:String="")

Public
	Method Close:Int() ' sqlite3_close
	Method Exec:Int(sql:String, callback:ExtSQLite3Callback=Null) ' sqlite3_exec
	Method Prepare:ExtSQLite3Statement(sql:String) Abstract
End

Class ExtSQLite3Statement
Protected
	Method Init:Int(db:ExtSQLite3Database, sql:String)

Public
	Method Finalize:Void()

	' binding methods
	Method BindFloat:Int(index:Int, value:Float) ' sqlite3_bind_double
	Method BindInt:Int(index:Int, value:Int) ' sqlite3_bind_int
	Method BindString:Int(index:Int, value:String) ' sqllite3_bind_text
	Method BindNull:Int(index:Int) ' sqlite3_bind_null

	' result methods
	Method NextRow:Int() ' sqlite3_step
	Method GetFloat:Float(index:Int) ' sqlite3_column_double
	Method GetInt:Int(index:Int) ' sqlite3_column_int
	Method GetString:String(index:Int) ' sqlite3_column_text
	Method GetType:Int(index:Int) ' sqlite3_column_type
End

Public
Class SQLite3Database Extends ExtSQLite3Database Final
Public
	Method New(filename:String="", flags:Int=-1, vfs:String="")
		Init(filename, flags, vfs)
	End

	Method Prepare:ExtSQLite3Statement(sql:String)
		Return New SQLite3Statement(Self, sql)
	End
End

Class SQLite3Statement Extends ExtSQLite3Statement Final
Private
	Method New(db:SQLite3Database, sql:String)
		Init(db, sql)
	End
End

Class SQLite3Callback Extends ExtSQLite3Callback
End
