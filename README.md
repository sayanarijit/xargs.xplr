[![xplr-xargs.gif](https://s6.gifyu.com/images/xplr-xargs.gif)](https://gifyu.com/image/A1Eg)

Batch execute commands on the focused or selected files using `xargs`.


Requirements
------------

- [xargs](https://www.gnu.org/software/findutils/manual/html_node/find_html/xargs-options.html)


Installation
------------

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'
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
  }

  -- Type `X` for xarsg mode.
  ```


Features
--------

- Run multiple commands without having to reselect the paths.
- Selection will clear when you leave the mode.
