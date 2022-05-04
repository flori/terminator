# terminator

## Description

Builds a go binary that terminates all processes running the configured
executable (see below). This can be useful if you want run it as `sudo
/path/to/terminator` and only allowing a sudo call to this specific path for
example when terminating a sidecar container when `shareProcessNamespace: true`
was configured and your main container has finished its task.


## Installation

```
go install -ldflags '-X main.Executable=/cloud_sql_proxy' github.com/flori/terminator/cmd/terminator@latest
```

## Example

See the cronjob.yml in this repo for a minimal example on how to use this
program to terminate a process running in a sidecar container.

## Author

Florian Frank <mailto:flori@ping.de>

## License

MIT License
