/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1999,2008 Oracle.  All rights reserved.
 *
 * $Id: env_globals.c 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "db_config.h"

/*
 * This is the file that initializes the global array.  Do it this way because
 * people keep changing the structure without changing the initialization code.
 * Having declaration and initialization in one file will hopefully fix that.
 */
#define	DB_INITIALIZE_DB_GLOBALS	1

#include "db_int.h"
