/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1997,2008 Oracle.  All rights reserved.
 *
 * $Id: os_abs.c 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "db_config.h"

#include "db_int.h"

/*
 * __os_abspath --
 *	Return if a path is an absolute path.
 *
 * PUBLIC: int __os_abspath __P((const char *));
 */
int
__os_abspath(path)
	const char *path;
{
	return (path[0] == '/');
}
