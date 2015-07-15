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
Class ExtSQLite3Database Abstract
Private
	Method _Init:Int(filename:String, flags:Int=-1, vfs:String="")
	Method _Exec:Int(sql:String)
	Method _Close:Int()
End

Class ExtSQLite3Statement
Private
	Method _Init:Int(db:ExtSQLite3Database, sql:String)
	Method _Finalize:Void()
	Method _BindFloat:Int(index:Int, value:Float)
	Method _BindInt:Int(index:Int, value:Int)
	Method _BindString:Int(index:Int, value:String)
	Method _BindNull:Int(index:Int)
	Method _NextRow:Int()
	Method _GetFloat:Float(index:Int)
	Method _GetInt:Int(index:Int)
	Method _GetString:String(index:Int)
	Method _GetType:Int(index:Int)
End

Public
Class SQLite3Database Extends ExtSQLite3Database Final
Public
	Method New(filename:String="", flags:Int=-1, vfs:String="")
		_Init(filename, flags, vfs)
	End

	Method Prepare:SQLite3Statement(sql:String)
		Return New SQLite3Statement(Self, sql)
	End

	Method Close:Int()
		Return _Close()
	End

	Method Exec:Int(sql:String)
		Return _Exec(sql)
	End
End

Class SQLite3Statement Extends ExtSQLite3Statement Final
Private
	Method New(db:SQLite3Database, sql:String)
		_Init(db, sql)
	End

Public
	Method Finalize:Void(); _Finalize(); End

	' binding methods
	Method BindFloat:Int(index:Int, value:Float); Return _BindFloat(index, value); End
	Method BindInt:Int(index:Int, value:Int); Return _BindInt(index, value); End
	Method BindString:Int(index:Int, value:String); Return _BindString(index, value); End
	Method BindNull:Int(index:Int); Return _BindNull(index); End

	' result methods
	Method NextRow:Int(); Return _NextRow(); End
	Method GetFloat:Float(index:Int); Return _GetFloat(index); End
	Method GetInt:Int(index:Int); Return _GetInt(index); End
	Method GetString:String(index:Int); Return _GetString(index); End
	Method GetType:Int(index:Int); Return _GetType(index); End
End
