/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2005,2008 Oracle.  All rights reserved.
 *
 * $Id: isprint.c 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "db_config.h"

#include "db_int.h"

/*
 * isprint --
 *
 * PUBLIC: #ifndef HAVE_ISPRINT
 * PUBLIC: int isprint __P((int));
 * PUBLIC: #endif
 */
int
isprint(c)
	int c;
{
	/*
	 * Depends on ASCII character values.
	 */
	return ((c >= ' ' && c <= '~') ? 1 : 0);
}
