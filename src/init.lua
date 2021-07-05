local function parse_args(args)
  if args == nil then
    args = {}
  end

  if args.mode == nil then
    args.mode = "default"
  end

  if args.key == nil then
    args.key = "X"
  end

  if args.placeholder == nil then
    args.placeholder = "{}"
  end

  if args.shell == nil then
    args.shell = "bash"
  end

  return args
end

local function create_xargs_mode(custom, mode, command)
  custom["xargs_" .. mode] = {
    name = "map " .. mode,
    key_bindings = {
      on_key = {
        enter = {
          help = "execute",
          messages = {
            { BashExec = command },
          }
        },
        backspace = {
          help = "remove last character",
          messages = {"RemoveInputBufferLastCharacter"}
        },
        ["ctrl-u"] = {
          help = "remove line",
          messages = {
            { SetInputBuffer = "" },
          }
        },
        ["ctrl-w"] = {
          help = "remove last word",
          messages = {"RemoveInputBufferLastWord"}
        },
        esc = {
          help = "cancel",
          messages = {"PopMode", "ClearSelection"}
        },
        ["ctrl-c"] = {
          help = "terminate",
          messages = {"Terminate"}
        },
      },
      default = {
        messages = {"BufferInputFromKey"}
      },
    }
  }
end


local function setup(args)

  local xplr = xplr

  args =  parse_args(args)

  xplr.config.modes.builtin[args.mode].key_bindings.on_key[args.key] = {
    help = "xargs",
    messages = {
      "PopMode",
      { SwitchModeCustom = "xargs" },
    }
  }

  xplr.config.modes.custom.xargs = {
    name = "xargs",
    key_bindings = {
      on_key = {
        s = {
          help = "single line",
          messages = {
            "PopMode",
            { SwitchMode = "xargs_single" },
            { SetInputBuffer = "" },
          }
        },
        m = {
          help = "multi line",
          messages = {
            "PopMode",
            { SwitchMode = "xargs_multi" },
            { SetInputBuffer = "" },
          }
        },
        esc = {
          help = "cancel",
          messages = { "PopMode" }
        },
        ["ctrl-c"] = {
          help = "terminate",
          messages = { "Terminate" }
        },
      }
    }
  }

  create_xargs_mode(
    xplr.config.modes.custom,
    "single",
    [===[
    if [ "$XPLR_INPUT_BUFFER" ]; then
      echo 'SetInputBuffer: ""' >> "${XPLR_PIPE_MSG_IN:?}"
      xargs -r -a "$XPLR_PIPE_RESULT_OUT" ${XPLR_INPUT_BUFFER:?}
      read -p "[press enter to continue]"
    else
      echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
    fi
    ]===]
  )

  create_xargs_mode(
    xplr.config.modes.custom,
    "multi",
    [===[
    if [ "$XPLR_INPUT_BUFFER" ]; then
      echo 'SetInputBuffer: ""' >> "${XPLR_PIPE_MSG_IN:?}"
      xargs -I ]===] .. args.placeholder .. [===[ -r -a "$XPLR_PIPE_RESULT_OUT" ]===] .. args.shell .. [===[ -c "${XPLR_INPUT_BUFFER:?}"
      read -p "[press enter to continue]"
    else
      echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
    fi
    ]===]
  )
end

return { setup = setup }
