package org.example.bug;

import io.avaje.inject.BeanScope;

public class Launcher {
    public static void main(String[] args) {
        try (final var beans = BeanScope.builder().build()) {
            final var factory = beans.get(TestFactory.class);
            System.out.println(factory);
        }
    }
}
