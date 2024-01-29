local builtin = require('telescope.builtin')
local keymap = vim.keymap.set

keymap('n', '<Leader>ff', builtin.find_files, {})
keymap('n', '<Leader>fg', builtin.live_grep, {})
