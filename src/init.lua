local function setup(args)

  local xplr = xplr

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

  xplr.config.modes.builtin[args.mode].key_bindings.on_key[args.key] = {
    help = "xargs",
    messages = {
      "PopMode",
      { SwitchModeCustom = "xargs" },
      { SetInputBuffer = "" },
    }
  }

  xplr.config.modes.custom.xargs = {
    name = "xargs",
    key_bindings = {
      on_key = {
        enter = {
          help = "execute",
          messages = {
            {
              BashExec = [===[
              xargs -I "{}" -r -a "$XPLR_PIPE_RESULT_OUT" ${XPLR_INPUT_BUFFER:?}
              read -p "[press enter to continue]"
              ]===]
            },
            { SetInputBuffer = "" },
          }
        },
        backspace = {
          help = "remove last character",
          messages = {"RemoveInputBufferLastCharacter"}
        },
        ["ctrl-c"] = {
          help = "terminate",
          messages = {"Terminate"}
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
      },
      default = {
        messages = {"BufferInputFromKey"}
      },
    }
  }
end

return { setup = setup }
