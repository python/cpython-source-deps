/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 2002,2008 Oracle.  All rights reserved.
 *
 * $Id: TestEntity.java 63573 2008-05-23 21:43:21Z trent.nelson $
 */

package com.sleepycat.collections.test;

/**
 * @author Mark Hayes
 */
class TestEntity {

    int key;
    int value;

    TestEntity(int key, int value) {

        this.key = key;
        this.value = value;
    }

    public boolean equals(Object o) {

        try {
            TestEntity e = (TestEntity) o;
            return e.key == key && e.value == value;
        } catch (ClassCastException e) {
            return false;
        }
    }

    public int hashCode() {

        return key;
    }

    public String toString() {

        return "[key " + key + " value " + value + ']';
    }
}
