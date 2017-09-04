/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2002,2008 Oracle.  All rights reserved.
 *
 * $Id: DeletedClassException.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */

package com.sleepycat.persist.evolve;


/**
 * While reading from an index, an instance of a deleted class version was
 * encountered.
 *
 * @see com.sleepycat.persist.evolve Class Evolution
 * @author Mark Hayes
 */
public class DeletedClassException extends RuntimeException {

    public DeletedClassException(String msg) {
        super(msg);
    }
}
