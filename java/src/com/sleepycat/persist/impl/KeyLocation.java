/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2002,2008 Oracle.  All rights reserved.
 *
 * $Id: KeyLocation.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */

package com.sleepycat.persist.impl;

/**
 * Holder for the input and format of a key.  Used when copying secondary keys.
 * Returned by RecordInput.getKeyLocation().
 *
 * @author Mark Hayes
 */
class KeyLocation {

    RecordInput input;
    Format format;

    KeyLocation(RecordInput input, Format format) {
        this.input = input;
        this.format = format;
    }
}
