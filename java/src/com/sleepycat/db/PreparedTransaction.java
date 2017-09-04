/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1999,2008 Oracle.  All rights reserved.
 *
 * $Id: PreparedTransaction.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */
package com.sleepycat.db;

import com.sleepycat.db.internal.DbTxn;

/**
The PreparedTransaction object is used to encapsulate a single prepared,
but not yet resolved, transaction.
*/
public class PreparedTransaction {
    private byte[] gid;
    private Transaction txn;

    PreparedTransaction(final DbTxn txn, final byte[] gid) {
        this.txn = new Transaction(txn);
        this.gid = gid;
    }

    public byte[] getGID() {
        return gid;
    }

    /**
    Return the transaction handle for the transaction.
    <p>
    @return
    The transaction handle for the transaction.
    */
    public Transaction getTransaction() {
        return txn;
    }
}
