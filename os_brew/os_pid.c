/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2001,2008 Oracle.  All rights reserved.
 *
 * $Id: os_pid.c 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "db_config.h"

#include "db_int.h"

/*
 * __os_id --
 *	Return the current process ID.
 */
void
__os_id(dbenv, pidp, tidp)
	DB_ENV *dbenv;
	pid_t *pidp;
	db_threadid_t *tidp;
{
	AEEApplet *app;

	COMPQUIET(dbenv, NULL);

	if (pidp != NULL) {
		app = (AEEApplet *)GETAPPINSTANCE();
		*pidp = (pid_t)ISHELL_ActiveApplet(app->m_pIShell);
	}
	if (tidp != NULL)
		*tidp = 0;
}
