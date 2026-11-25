# Tasks for Lab 1

Automation with bash. Write a bash script for each task. To run a script, make it executable with `chmod`, for example `chmod +x <script filename>`. Upload the tested scripts to a GitHub repository.

## Task 1.
Write a script that checks disk space usage of the root partition `/`. If the free space on any partition drops below 10% (or another given threshold), the script must print a warning. Use the `df` command.

## Task 2.
Write a script that counts the files of a given type (extension) in a given directory. The script must take two arguments: the directory path and the file extension (for example, `txt`, `sh`, `log`). Print the result in the format: "Directory [path] has [N] files with extension .[ext]."

## Task 3.
Write a script that creates a new directory for logs or data named after the current date. The directory must be created in the current working directory. The name format is `YYYY-MM-DD` (for example, `2025-10-23`). The script must check whether a directory with this name already exists. If it exists, print "Directory exists: [dirname]". Use the `date` command to format the name.

## Task 4.
System diagnostics. Write a script that collects and prints basic information about the system:
- the host name (`hostname`);
- IP addresses and interface names (`ip address`, `grep`, `awk`);
- the Linux kernel version (`uname -r`);
- how long the system has been running (`uptime`);
- the current user (`whoami`).

## References
- https://acode.com.ua/bash-in-linux/
- https://freehost.com.ua/ukr/faq/articles/komandnaja-obolochka-bash--ponjatie-komandi-i-ispolzovanie/
- https://linuxconfig.org/bash-scripting-tutorial

## Solutions

| Task | Script                                       | What it does                                              |
|------|----------------------------------------------|-----------------------------------------------------------|
| 1    | [check_disk_space.sh](check_disk_space.sh)   | Warns when free space drops below a threshold             |
| 2    | [count_files.sh](count_files.sh)             | Counts files with an extension in a directory             |
| 3    | [make_date_dir.sh](make_date_dir.sh)         | Creates a `YYYY-MM-DD` directory in the current directory |
| 4    | [system_info.sh](system_info.sh)             | Prints host name, IP addresses, kernel, uptime and user   |

## How to run

Run the scripts from the repository root. They are committed as executable; if the permission is lost (for example after downloading a zip), restore it with:

```bash
chmod +x lab_1/*.sh
```

### Task 1 — disk space
Checks `/` with a 10% threshold by default. The first argument sets another threshold, the rest pick other mount points.

```bash
lab_1/check_disk_space.sh
lab_1/check_disk_space.sh 20
lab_1/check_disk_space.sh 20 / /home
```

```text
OK: / has 63% free space (threshold 10%)
WARNING: /home has only 8% free space (threshold 10%)
```

The exit code is `0` when every filesystem has enough space, `1` when at least one is below the threshold and `2` for invalid arguments, so the script can be used in cron jobs or CI.

### Task 2 — count files
Counts regular files in the directory and all its subdirectories. The extension works with or without the leading dot.

```bash
lab_1/count_files.sh lab_1 sh
lab_1/count_files.sh /var/log .log
```

```text
Directory lab_1 has 4 files with extension .sh.
```

### Task 3 — dated directory
Creates the directory in the directory you run the script from.

```bash
lab_1/make_date_dir.sh
lab_1/make_date_dir.sh
```

```text
Directory created: 2026-11-25
Directory exists: 2026-11-25
```

### Task 4 — system diagnostics
```bash
lab_1/system_info.sh
```

```text
Hostname: my-laptop
IP addresses (without loopback):
  wlan0        inet   192.168.1.10/24
  wlan0        inet6  fe80::1c2d:3e4f:5a6b:7c8d/64
Kernel:   6.12.1-arch1-1
Uptime:   up 1 hour, 54 minutes (since 2026-11-25 10:20:18)
User:     student
```
