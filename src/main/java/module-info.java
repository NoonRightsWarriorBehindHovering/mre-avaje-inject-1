import io.avaje.inject.spi.Module;
import org.example.bug.BugModule;

module bug {
    requires io.avaje.inject;
    requires jakarta.inject;

    provides Module with BugModule;
}