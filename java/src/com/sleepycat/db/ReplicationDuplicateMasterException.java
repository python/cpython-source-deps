/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1997,2008 Oracle.  All rights reserved.
 *
 * $Id: ReplicationDuplicateMasterException.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */
package com.sleepycat.db;

import com.sleepycat.db.internal.DbEnv;

/**
The replication group has more than one master.  The application should
reconfigure itself as a client by calling the
{@link com.sleepycat.db.Environment#startReplication Environment.startReplication} method, and then call for an election by
calling {@link com.sleepycat.db.Environment#electReplicationMaster Environment.electReplicationMaster}.
*/
public class ReplicationDuplicateMasterException extends DatabaseException {
    /* package */ ReplicationDuplicateMasterException(final String s,
                                   final int errno,
                                   final DbEnv dbenv) {
        super(s, errno, dbenv);
    }
}
