/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2001,2008 Oracle.  All rights reserved.
 *
 * $Id: BtreePrefixCalculator.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */

package com.sleepycat.db;

/**
An interface specifying how Btree prefixes should be calculated.
*/
public interface BtreePrefixCalculator {
    /**
    The application-specific Btree prefix callback.
    <p>
    @param db
    The enclosing database handle.
    @param dbt1
    A database entry representing a database key.
    @param dbt2
    A database entry representing a database key.
    */
    int prefix(Database db, DatabaseEntry dbt1, DatabaseEntry dbt2);
}
