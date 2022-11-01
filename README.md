## container-signals
Short and sweet example for using `trap` in BASH with Docker containers to handle signals/container stop requests

**Note**: While this uses *tini* as a very simple init process (PID 1) to handle spawning the actual process/pass signals, the image doesn't _need_ to include it.

It's included with Docker when using the `--init` option, see [upstream](https://github.com/krallin/tini)

## Example

See below for an example of how the script in the container traps the signal, and runs through some mock cleanup steps

The top pane shows the stop request on the container, while the bottom pane shows the logs.

![example-screen](./Trapped_Shutdown_Screenshot.png)
