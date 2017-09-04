/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2006,2008 Oracle.  All rights reserved.
 *
 * $Id: rep_common.h 63573 2008-05-23 21:43:21Z trent.nelson $
 */

/* Data shared by both repmgr and base versions of this program. */
typedef struct {
	int is_master;
} SHARED_DATA;

int create_env __P((const char *progname, DB_ENV **));
int doloop __P((DB_ENV *, SHARED_DATA *));
int env_init __P((DB_ENV *, const char *));
void usage __P((const char *));
