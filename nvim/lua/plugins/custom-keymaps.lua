-- s プレフィックスのキーマップを最後に確実に適用
return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- s プレフィックスを LazyVim レベルで予約
      { "s", "<Nop>", desc = "Window prefix" },
      { "sp", "<cmd>tabprevious<cr>", desc = "Previous tab" },
      { "sn", "<cmd>tabnext<cr>", desc = "Next tab" },
      { "sN", "<cmd>bnext<cr>", desc = "Next buffer" },
      { "sP", "<cmd>bprevious<cr>", desc = "Previous buffer" },
      { "sh", "<C-w>h", desc = "Go to left window" },
      { "sj", "<C-w>j", desc = "Go to lower window" },
      { "sk", "<C-w>k", desc = "Go to upper window" },
      { "sl", "<C-w>l", desc = "Go to right window" },
      { "sH", "<C-w>H", desc = "Move window left" },
      { "sJ", "<C-w>J", desc = "Move window down" },
      { "sK", "<C-w>K", desc = "Move window up" },
      { "sL", "<C-w>L", desc = "Move window right" },
      { "ss", "<cmd>split<cr>", desc = "Split horizontal" },
      { "sv", "<cmd>vsplit<cr>", desc = "Split vertical" },
      { "sq", "<cmd>q<cr>", desc = "Close window" },
      { "sQ", "<cmd>bdelete<cr>", desc = "Delete buffer" },
      { "st", "<cmd>tabnew<cr>", desc = "New tab" },
      { "so", "<C-w>_<C-w>|", desc = "Maximize window" },
      { "sO", "<C-w>=", desc = "Equal windows" },
      { "sw", "<C-w>w", desc = "Next window" },
      { "sr", "<C-w>r", desc = "Rotate windows" },
      { "s=", "<C-w>=", desc = "Equal windows" },
    },
  },
}
