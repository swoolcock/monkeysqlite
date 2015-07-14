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

' Primary Result Code List
Const SQLITE_ABORT% = (4)
Const SQLITE_AUTH% = (23)
Const SQLITE_BUSY% = (5)
Const SQLITE_CANTOPEN% = (14)
Const SQLITE_CONSTRAINT% = (19)
Const SQLITE_CORRUPT% = (11)
Const SQLITE_DONE% = (101)
Const SQLITE_EMPTY% = (16)
Const SQLITE_ERROR% = (1)
Const SQLITE_FORMAT% = (24)
Const SQLITE_FULL% = (13)
Const SQLITE_INTERNAL% = (2)
Const SQLITE_INTERRUPT% = (9)
Const SQLITE_IOERR% = (10)
Const SQLITE_LOCKED% = (6)
Const SQLITE_MISMATCH% = (20)
Const SQLITE_MISUSE% = (21)
Const SQLITE_NOLFS% = (22)
Const SQLITE_NOMEM% = (7)
Const SQLITE_NOTADB% = (26)
Const SQLITE_NOTFOUND% = (12)
Const SQLITE_NOTICE% = (27)
Const SQLITE_OK% = (0)
Const SQLITE_PERM% = (3)
Const SQLITE_PROTOCOL% = (15)
Const SQLITE_RANGE% = (25)
Const SQLITE_READONLY% = (8)
Const SQLITE_ROW% = (100)
Const SQLITE_SCHEMA% = (17)
Const SQLITE_TOOBIG% = (18)
Const SQLITE_WARNING% = (28)

' Extended Result Code List
Const SQLITE_ABORT_ROLLBACK% = (516)
Const SQLITE_BUSY_RECOVERY% = (261)
Const SQLITE_BUSY_SNAPSHOT% = (517)
Const SQLITE_CANTOPEN_CONVPATH% = (1038)
Const SQLITE_CANTOPEN_FULLPATH% = (782)
Const SQLITE_CANTOPEN_ISDIR% = (526)
Const SQLITE_CANTOPEN_NOTEMPDIR% = (270)
Const SQLITE_CONSTRAINT_CHECK% = (275)
Const SQLITE_CONSTRAINT_COMMITHOOK% = (531)
Const SQLITE_CONSTRAINT_FOREIGNKEY% = (787)
Const SQLITE_CONSTRAINT_FUNCTION% = (1043)
Const SQLITE_CONSTRAINT_NOTNULL% = (1299)
Const SQLITE_CONSTRAINT_PRIMARYKEY% = (1555)
Const SQLITE_CONSTRAINT_ROWID% = (2579)
Const SQLITE_CONSTRAINT_TRIGGER% = (1811)
Const SQLITE_CONSTRAINT_UNIQUE% = (2067)
Const SQLITE_CONSTRAINT_VTAB% = (2323)
Const SQLITE_CORRUPT_VTAB% = (267)
Const SQLITE_IOERR_ACCESS% = (3338)
Const SQLITE_IOERR_BLOCKED% = (2826)
Const SQLITE_IOERR_CHECKRESERVEDLOCK% = (3594)
Const SQLITE_IOERR_CLOSE% = (4106)
Const SQLITE_IOERR_CONVPATH% = (6666)
Const SQLITE_IOERR_DELETE% = (2570)
Const SQLITE_IOERR_DELETE_NOENT% = (5898)
Const SQLITE_IOERR_DIR_CLOSE% = (4362)
Const SQLITE_IOERR_DIR_FSYNC% = (1290)
Const SQLITE_IOERR_FSTAT% = (1802)
Const SQLITE_IOERR_FSYNC% = (1034)
Const SQLITE_IOERR_GETTEMPPATH% = (6410)
Const SQLITE_IOERR_LOCK% = (3850)
Const SQLITE_IOERR_MMAP% = (6154)
Const SQLITE_IOERR_NOMEM% = (3082)
Const SQLITE_IOERR_RDLOCK% = (2314)
Const SQLITE_IOERR_READ% = (266)
Const SQLITE_IOERR_SEEK% = (5642)
Const SQLITE_IOERR_SHMLOCK% = (5130)
Const SQLITE_IOERR_SHMMAP% = (5386)
Const SQLITE_IOERR_SHMOPEN% = (4618)
Const SQLITE_IOERR_SHMSIZE% = (4874)
Const SQLITE_IOERR_SHORT_READ% = (522)
Const SQLITE_IOERR_TRUNCATE% = (1546)
Const SQLITE_IOERR_UNLOCK% = (2058)
Const SQLITE_IOERR_WRITE% = (778)
Const SQLITE_LOCKED_SHAREDCACHE% = (262)
Const SQLITE_NOTICE_RECOVER_ROLLBACK% = (539)
Const SQLITE_NOTICE_RECOVER_WAL% = (283)
Const SQLITE_READONLY_CANTLOCK% = (520)
Const SQLITE_READONLY_DBMOVED% = (1032)
Const SQLITE_READONLY_RECOVERY% = (264)
Const SQLITE_READONLY_ROLLBACK% = (776)
Const SQLITE_WARNING_AUTOINDEX% = (284)
