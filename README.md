<div align="center">
  <h1>leetcode-nvim</h1>
</div>

Sovling leetcode question in neovim, based on leetcode-cli

# Showcase

> The showcase update is not timely

<details><summary> <b>Images (Click to expand!)</b></summary>

<h2> List Questions </h2>

![List questions](./assets/list.gif?raw=true)

<h2> Test Question </h2>

![Test question](./assets/test.gif?raw=true)

<h2> Submit Question </h2>

![Submit question](./assets/submit.gif?raw=true)

</details>

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
  cmd = {"LCode"},
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
:LCode list     -- To list all questions
:LCode test     -- To test question
:LCode submit   -- To submit question
```

#### Welcome to submit Issues and PR
