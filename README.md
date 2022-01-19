Batch execute commands on the focused or selected files using `xargs`.

> **NOTE:** You might want to check out a better version of this plugin:
> [**map.xplr**](https://github.com/sayanarijit/map.xplr)

## Usage

### Single map mode

Maps all the paths as arguments to a single command.

[![xplr-xargs-single.gif](https://s6.gifyu.com/images/xplr-xargs-single.gif)](https://gifyu.com/image/A156)

### Multi map mode

Maps each path to the given command by substituting the placeholder with the
path.

[![xplr-xargs-multi.gif](https://s6.gifyu.com/images/xplr-xargs-multi.gif)](https://gifyu.com/image/A1tP)

## Requirements

- [xargs](https://www.gnu.org/software/findutils/manual/html_node/find_html/xargs-options.html)

## Installation

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  local home = os.getenv("HOME")
  package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. package.path
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/sayanarijit/xargs.xplr ~/.config/xplr/plugins/xargs
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("xargs").setup()

  -- Or

  require("xargs").setup{
    mode = "default",
    key = "X",
    placeholder = "{}",
    shell = "bash",
  }

  -- Type `Xs` for xargs single map mode.
  -- Type `Xm` for xargs multi map mode.
  ```

## Features

- Run multiple commands without having to reselect the paths.
- Selection will clear when you leave the mode.
- Single map mode will pass all the paths as arguments to a single command.
- Multi map mode will run the command for each path by substituting the
  placeholder with the path.
- Multiline map will run the command inside the specified shell.
