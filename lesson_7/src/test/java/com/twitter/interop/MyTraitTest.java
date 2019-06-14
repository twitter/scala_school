package com.twitter.interop;

import java.io.IOException;

import org.junit.*;
import static org.junit.Assert.*;
import scala.runtime.AbstractFunction0;
import scala.runtime.AbstractFunction1;

public class MyTraitTest {
    @Test public void simpleClassTest() {
        SimpleClass s = new SimpleClass("foo", "bar", "mutable");
        // vals
        assertTrue(s.foo().equals("foo"));
        // vars
        assertTrue(s.bar().equals("bar"));
        s.bar_$eq("newbar");
        assertTrue(s.bar().equals("newbar"));
        // bean vals
        assertTrue(s.getFooBean().equals("foobean"));
        assertTrue(s.getBarBean().equals("barbean"));
        s.setBarBean("newbarbean");
        assertTrue(s.getBarBean().equals("newbarbean"));

        // boolean bean vals
        assertTrue(s.isAwesome());
        s.setAwesome(false);
        assertFalse(s.isAwesome());

        // bean properties work on class args too
        s.setMutable("newmutable");
        assertTrue(s.getMutable().equals("newmutable"));

        // exception erasure!
        try {
            s.dangerFoo();
        } catch (Throwable t) {
            // UGLY
        }
        // @throws works
        try {
            s.dangerBar();
        } catch (IOException e) {
            // whew!
        }
    }
    @Test public void traitTest() {
        // the ugly way
        MyTrait foo = TraitImpl$.MODULE$.apply("foo");
        // the prettier way: forwarding methods
        foo = TraitImpl.apply("foo");
    }

    @Test public void closureTest() {
        ClosureClass c = new ClosureClass();
        c.printResult(new AbstractFunction0() {
                public String apply() {
                    return "foo";
                }
            });
        c.printResult(new AbstractFunction1<String, String>() {
                public String apply(String arg) {
                    return arg + "foo";
                }
            });
    }

    @Test public void varianceTest() {
        VarianceClass<String, Object> v1 = new VarianceClass<String, Object>("foo");
        Locale l = Locale$en_US$.MODULE$;
        System.out.println(l);
        v1.printT("foo");
    }
}

