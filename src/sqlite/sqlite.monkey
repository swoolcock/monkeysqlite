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

#Rem
Usage for MinGW builds:
1) Copy "sqlite3.h" to MinGW/include
2) Copy "libsqlite3.a" to MinGW/lib
3) Do an initial build for the desired target.
4) Copy "sqlite3.dll" to the build directory.
5) Add to CONFIG.MONKEY in the build directory: #CC_LIBS="-lsqlite3"

Currently only supports Windows C++ targets, Mac/Linux/Android/iOS support planned.
#End

Strict

Public
Import sqlite.externs
Import sqlite.constants
