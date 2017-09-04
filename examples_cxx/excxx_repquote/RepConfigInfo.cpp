/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2001,2008 Oracle.  All rights reserved.
 *
 * $Id: RepConfigInfo.cpp 63573 2008-05-23 21:43:21Z trent.nelson $
 */

#include "RepConfigInfo.h"

RepConfigInfo::RepConfigInfo()
{
	start_policy = DB_REP_ELECTION;
	home = "TESTDIR";
	got_listen_address = false;
	totalsites = 0;
	priority = 100;
	verbose = false;
	other_hosts = NULL;
}

RepConfigInfo::~RepConfigInfo()
{
	// release any other_hosts structs.
	if (other_hosts != NULL) {
		REP_HOST_INFO *CurItem = other_hosts;
		while (CurItem->next != NULL)
		{
			REP_HOST_INFO *TmpItem = CurItem;
			free(CurItem);
			CurItem = TmpItem;
		}
		free(CurItem);
	}
	other_hosts = NULL;
}

void RepConfigInfo::addOtherHost(char* host, int port, bool peer)
{
	REP_HOST_INFO *newinfo;
	newinfo = (REP_HOST_INFO*)malloc(sizeof(REP_HOST_INFO));
	newinfo->host = host;
	newinfo->port = port;
	newinfo->peer = peer;
	if (other_hosts == NULL) {
		other_hosts = newinfo;
		newinfo->next = NULL;
	} else {
		newinfo->next = other_hosts;
		other_hosts = newinfo;
	}
}
