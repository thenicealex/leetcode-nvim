<div align="center">
  <h1>leetcode-nvim</h1>
</div>

Sovling leetcode question in neovim, based on leetcode-cli

# Shows

## List Questions

![List questions](./assets/list.gif?raw=true)

## Test Question

![Test question](./assets/test.gif?raw=true)

## Submit Question

![Submit question](./assets/submit.gif?raw=true)

# Quickstart

## Requirements

- **Neovim 0.9.1** or later
- **leetcode-cli** is installed and log in
```shell
npm -g install leetcode-tools/leetcode-cli
```

## Installation

You can install `leetcode-nvim` with lazy.nvim

```lua
{
  "thenicealex/leetcode-nvim",
  cmd = { "LCList", "LCTest", "LCSubmit", "LCDisplay" },
  opts = {},
  dependencies = {"nvim-telescope/telescope.nvim"}
  config = function (_, opts)
    require("leetcode").set(opts)
  end
}
```

### Default config
```lua
{
  domin = "cn",
  language = "cpp",
  directory = "~/.leetcode",
}
```

## Commands

```vim
:LCList     -- To list all questions
:LCTest     -- To test question
:LCSubmit   -- To submit question
```

#### Welcome to submit Issues and PR
