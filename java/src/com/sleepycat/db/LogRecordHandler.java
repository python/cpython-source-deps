/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2000,2008 Oracle.  All rights reserved.
 *
 * $Id: LogRecordHandler.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */
package com.sleepycat.db;

/**
A function to process application-specific log records.
**/
public interface LogRecordHandler {
    /**
    A function to process application-specific log records.
    @param environment
    The enclosing database environment.
    @param logRecord
    A log record.
    @param lsn
    The log record's log sequence number.
    @param operation
    The recovery operation being performed.
    @return
    The function must return 0 on success and either the system errno
    or a value outside of the Berkeley DB error name space on failure.
    */
    int handleLogRecord(Environment environment,
                        DatabaseEntry logRecord,
                        LogSequenceNumber lsn,
                        RecoveryOperation operation);
}
