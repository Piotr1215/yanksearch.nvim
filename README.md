# Yank Search Registry

This is a super simple plugin that checks the search registry `/` and runs the
search again for the search phrase and creates a dedicated buffer with the
output.

It is useful for quick text manipulation on the search output.

## Usage

## Format

Format use `stylua` and provide `.stylua.toml`.

## Test

Use vusted for test install by using `luarocks --lua-version=5.1 install vusted` then run `vusted test`
for your test cases.

Create test case in test folder file rule is `foo_spec.lua` with `_spec` more usage please check
[busted usage](https://lunarmodules.github.io/busted/)

## Ci

Ci support auto generate doc from README and integration test and lint check by `stylua`.

## More

Other usage you can look at my plugins

## License MIT
