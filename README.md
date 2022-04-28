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

## Author

Florian Frank mailto:flori@ping.de

## License

MIT License
