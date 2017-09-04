/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1997,2008 Oracle.  All rights reserved.
 *
 * $Id: RunRecoveryException.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */
package com.sleepycat.db;

import com.sleepycat.db.internal.DbEnv;

/**
Thrown when the database environment needs to be recovered.
 *
Errors can occur in where the only solution is to shut down the
application and run recovery.  When a fatal error occurs, this
exception will be thrown, and all subsequent calls will also fail in
the same way.  When this occurs, recovery should be performed.
*/
public class RunRecoveryException extends DatabaseException {
    /* package */ RunRecoveryException(final String s,
                                   final int errno,
                                   final DbEnv dbenv) {
        super(s, errno, dbenv);
    }
}
