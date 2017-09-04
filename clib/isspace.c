/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2005,2008 Oracle.  All rights reserved.
 *
 * $Id: isspace.c 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "db_config.h"

#include "db_int.h"

/*
 * isspace --
 *
 * PUBLIC: #ifndef HAVE_ISSPACE
 * PUBLIC: int isspace __P((int));
 * PUBLIC: #endif
 */
int
isspace(c)
	int c;
{
	return (c == '\t' || c == '\n' ||
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
}
