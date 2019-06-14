package com.twitter.interop;

public class JTraitImpl implements MyTrait {
    private String name = null;

    public JTraitImpl(String name) {
        this.name = name;
    }

    public String traitName() {
        return name;
    }

    public String upperTraitName() {
        return MyTrait$class.upperTraitName(this);
    }
}
