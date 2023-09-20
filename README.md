# Yank Search Registry

This is a super simple plugin that checks the search registry `/` and runs the
search again for the search phrase and creates a dedicated buffer with the
output.

It is useful for quick text manipulation on the search output.

## Installation

### Using vim-plug

```vim
Plug 'piotr1215/yanksearch.nvim'
```

### Using packer.nvim

```lua
use 'piotr1215/yanksearch.nvim'
```

## Usage

To use the plugin, simply type `:YankMatchingLines` after performing a search.

### Dependencies

Neovim 0.5 or higher

## Configuration

As of the latest update, the plugin supports configuration options. You can specify the number of lines above, below, or around the matching line to be yanked as well.

Here's an example:

```lua
require('yanksearch').setup({
    lines_above = 1,
    lines_below = 1,
    lines_around = 0,
})
```

The plugin defaults to:

```lua
require('yanksearch').setup({
    lines_above = 0,
    lines_below = 0,
    lines_around = 0,
})
```

## Test

Tests are run with `vusted test`.

## Ci

Ci auto generates neovim help doc from README, so it's possible to run `h yanksearch`

## License MIT
