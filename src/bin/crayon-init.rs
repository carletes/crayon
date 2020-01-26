use nix::unistd::{chdir, getpid, getppid, getuid, setsid, Pid, Uid};
use std::process;

fn main() {
    println!("crayon-init: Starting");

    // Sanity check: Ensure we're PID 1.
    let pid = getpid();
    if pid != Pid::from_raw(1) {
        println!("crayon-init: Expected PID 1, got {}", pid);
        process::exit(1);
    }

    // Sanity check: Ensure our PPID is 0.
    let ppid = getppid();
    if ppid != Pid::from_raw(0) {
        println!("crayon-init: Expected PPID 0, got {}", ppid);
        process::exit(1);
    }

    // Sanity check: Ensure we're UID 0.
    let uid = getuid();
    if uid != Uid::from_raw(0) {
        println!("crayon-init: Expected UID 0, got {}", uid);
        process::exit(1);
    }

    // Create a new session and process group, becoming the session leader. We
    // have no controlling terminal now.
    //
    // TODO: Do wo really want to become session leader?
    //
    // TODO: Do we really want to lose the controlling terminal?
    //
    // TODO: If we do lose the controlling terminal, what happens to our logging
    // statements?
    let pgid = setsid().expect("crayon-init: setsid() failed --- already a process group leader??");
    println!("crayon-init: Process group id: {}", pgid);

    // Ensure we're at the root.
    chdir("/").expect("chdir(\"/\") failed");

    // TODO: Close `stdin`, since we do not need to read anything?

    // TODO: What about `stdout` and `stderr`?

    // TODO: Ensure sane `umask` --- what's sane?

    // TODO: Mount /tmp

    // TODO: Mount /proc ??

    // TODO: Mount /sys ??

    // TODO: Set up signal handlers.

    // TODO: Reap child loop ???
}
