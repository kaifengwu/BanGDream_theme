" ========== ⭐ Poppin'Party 主题设定 ==========

" ⭐ 自动加载 Poppin'Party 配色
colorscheme industry
hi Normal guibg=#1a1c2c guifg=#cdd6f4
"set background=dark
hi Normal guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 正常文本
hi CursorLine guibg=NONE " 当前行
hi NormalNC guibg=NONE ctermbg=NONE guifg=#c8b0e3 " 非活动窗口的正常文本
hi Pmenu guibg=NONE guifg=#c8b0e3 ctermbg=NONE " 弹出菜单
hi PmenuSel guibg=#c8b0e3 guifg=#0077DD ctermbg=NONE " 弹出菜单选中项
highlight CocFloating guibg=NONE guifg=#c8b0e3
highlight CocMenuSel guibg=#FF5522 guifg=#FF55BB gui=bold
set winblend=0
highlight NonText guibg=NONE " 非文本字符
highlight EndOfBuffer guibg=NONE " 缓冲区末尾


" 清除已有 match
function! s:ClearCursorLineMatch()
  if exists('w:roselia_cursor_match_id')
    call matchdelete(w:roselia_cursor_match_id)
    unlet w:roselia_cursor_match_id
  endif
endfunction

" 更新匹配区域
function! s:UpdateCursorLineMatch()
  call s:ClearCursorLineMatch()

  let lnum = line('.')
  let text = getline(lnum)
  let length = strlen(text)

  if length > 0
    " 使用 matchaddpos 高亮 [行号, 起始列, 长度]
    let w:roselia_cursor_match_id = matchaddpos('PoppinCursorLine', [[lnum, 1, length]])
  endif
endfunction

" 定义高亮颜色（你可以换颜色）
highlight PoppinCursorLine guibg=#202234

" 每次移动光标都更新
augroup PoppinCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI * call <SID>UpdateCursorLineMatch()
  autocmd BufLeave,WinLeave * call <SID>ClearCursorLineMatch()
augroup END


" ⭐ Poppin 应援色代码高亮
" Kasumi
highlight Identifier   guifg=#FF5522 " 标识符，例如变量名、函数名等
highlight vimAutoCmdSfxList     guifg=#FF5522
highlight Special      guifg=#FF5522 " 特殊字符，例如 @, #, $, %, & 等

" Otae
highlight Function     guifg=#0077DD " 函数，例如 print(), len() 等
highlight Label        guifg=#0077DD " 标签，例如 goto 标签
highlight Delimiter    guifg=#0077DD " 分隔符，例如逗号, 分号, 括号等
highlight Comment    guifg=#0077DD " 分隔符，例如逗号, 分号, 括号等

" Rimi
highlight Keyword      guifg=#FF55BB gui=bold " 关键字，例如 if, else, for 等
highlight Statement    guifg=#FF55BB " 语句，例如 return, break, continue 等

" Arisa
highlight Type         guifg=#AA66DD " 类型，例如 int, float, str 等
highlight scalaBlock   guifg=#AA66DD 
" Saaya
highlight Constant     guifg=#FFCC11 " 常量，例如 True, False, None 等
highlight Number       guifg=#FFCC11 " 数字，例如 1, 2.5, 3.14 等
highlight Boolean      guifg=#FFCC11 " 布尔值，例如 True, False

" Poppin'Party（#FF3377）
highlight PreProc      guifg=#FF3377 " 预处理指令，例如 #include, #define 等
highlight Todo         guifg=#FF3377 " 待办事项，例如 TODO, FIXME 等
highlight WarningMsg   guifg=#FF3377 " 警告信息，例如编译器警告
highlight vimMapRhs     guifg=#FF3377 
highlight vimMaplhs     guifg=#FF3377 
highlight vimUsrCmd     guifg=#FF3377 
highlight vimSetEqual   guifg=#FF3377 


highlight TSDelimiter    guifg=#66ff66 " 语法树分隔符，例如逗号, 分号, 括号等
highlight TSConstructor  guifg=#66ff66 " 语法树构造器，例如类, 函数等


function! DisplayPoppinLogo()
  let buf = nvim_create_buf(v:false, v:true)

  " 内容文本
  let lines = [
        \ "											═════════════⭐ Poppin'Party ⭐═════════════",
        \ "													市ヶ谷 有咲      山吹 沙綾",
		\ "														🎹				🥁",
		\ " ",
        \ "												牛込 りみ   戸山 かすみ		花園 たえ",
		\ "												   🎸			🎤				🎸",
        \ "											════════════════════════════════════════════",
        \ "											 ⭐Welcome to the world of Poppin'Party!⭐",
		\ "												⭐要写出kirakira dokidoki的代码哦⭐",
		\ "	                                                                        												",           
		\ "	                                                                        												",           
		\ "⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐",           
		\ "⭐																															  ⭐",           
		\ "⭐	,xOOOOOOOOx:                                lKOOc,'              ;dkOOkkkkOkl											  ⭐",
		\ "⭐	xN        ;xKo        ;O0xxkKOOOOkc       ;kXo :odNx      'xKxxKxWl        'dKo                  lKxxxKd				  ⭐",
		\ "⭐	 idW    ;l;;  ,WxdOOOOklcW:        ;KNxxxXOONX,    :Wdolc:coxW,  XxXd    :,    ,WkOOOOOd,;cllc,,:oO0d   0KdKOxxKdd0kOkx;  ⭐",
		\ "⭐	 lW,  cdddo   OXc    ,dXW;   ;dl:  ,K       ,Kc :ccWK::ckl;:x:cKk dW   looo,   Kx'    lNWo;;x0dlOl     ,:lX   KWK'  'Wx	  ⭐",
		\ "⭐	 ,No   cc;;   0   lx:  'N;  ,dddo  ;x  ,oxo, ;Wlc:oWx    ;   lWl  'Xd   l:;'  'N,,:0'  dW     ';xNk    clkk  ;W0   'Xk	  ⭐",
		\ "⭐	  0O        cXx   W0W   x,   ,'   'Kl   clo  dW'   Wx   XWc  'Wo   dW       'oNd,      ;W    K0 ;OK   xKoNo  ck   ,Nx	  ⭐",
		\ "⭐	  kX    okO0,xN'  :xo   X,   cloxO0W;      ;kXW;   Wx   NWl  'Wo   ,Xd   'k0O0O 'kkd   'W   lN:  OK   x00Wo      :Nl	  ⭐" ,
		\ "⭐	  xW    Wo    :Kx;   ,oXW,   Nk   dW   kNOc  cNc   Nk   WWd  ;Wl    xN    WdcxX' ':    ,W   xK,  xN;    kXX0'   oN;		  ⭐",
		\ "⭐	  oW'  'Wd        xOO  oW'   Wo   kK   Nx     ;0OkO00kkOO,0kO0      ;Nc   KO   0kxkOKkk00OkO0      :OOOOOoW:   kK		  ⭐",
		\ "⭐	   OOOO                d0kk0o     OOOOd                              0OOO                                 xOk0:			  ⭐",
		\ "⭐																															  ⭐",           
		\ "⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐",           
        \ ]

  call nvim_buf_set_lines(buf, 0, -1, v:false, lines)

  " 定义 highlight group（一次性定义即可）
  hi! PoppinTitle guifg=#FF3377 gui=bold
  hi! PoppinSong guifg=#FF3377
  hi! Kasumi      guifg=#FF5522
  hi! Otae        guifg=#0077DD
  hi! Arisa       guifg=#AA66DD
  hi! Saaya         guifg=#FFCC11
  hi! Rimi        guifg=#FF55BB
  hi! PoppinNote guifg=#FF3377

  " 应用 highlight 到特定行/列
" 第 0 行：Poppin 顶部标题
call nvim_buf_add_highlight(buf, -1, 'PoppinTitle', 0, 0, -1)

" 第 1 行：成员名字
call nvim_buf_add_highlight(buf, -1, 'Arisa', 1, 0,28)
call nvim_buf_add_highlight(buf, -1, 'Saaya',   1, 28, 60)

" 第 2 行：乐器 emoji
call nvim_buf_add_highlight(buf, -1, 'Arisa', 2, 16, 17)  " 🎹
call nvim_buf_add_highlight(buf, -1, 'Saaya',   2, 24, 25)  " 🥁

" 第 4 行：下方三人
call nvim_buf_add_highlight(buf, -1, 'Rimi',   4, 0,26)
call nvim_buf_add_highlight(buf, -1, 'Kasumi', 4, 26,44)
call nvim_buf_add_highlight(buf, -1, 'Otae',   4, 44,60)

" 第 5 行：下方 emoji
call nvim_buf_add_highlight(buf, -1, 'Rimi',   5, 15, 16)  " 🎸
call nvim_buf_add_highlight(buf, -1, 'Kasumi', 5, 20, 21)  " 🎤
call nvim_buf_add_highlight(buf, -1, 'Otae',   5, 26, 27)  " 🎸
" ASCII 图部分统一使用 PoppinArt
for l in range(6, 26)
  call nvim_buf_add_highlight(buf, -1, 'PoppinTitle', l, 0, -1)
endfor

" 最下方横线
call nvim_buf_add_highlight(buf, -1, 'PoppinFooter', 27, 0, -1)

  " 设置浮窗
  let width = 129
  let height = len(lines)
  let opts = {
        \ 'relative': 'editor',
        \ 'width': width,
        \ 'height': height,
        \ 'col': (&columns - width) / 2,
        \ 'row': (&lines - height) / 2,
        \ 'style': 'minimal',
        \ 'border': 'rounded'
        \ }

  let win = nvim_open_win(buf, v:true, opts)

  " 绑定 <ESC>/<CR> 关闭浮窗
  call nvim_buf_set_keymap(buf, 'n', '<ESC>', ':bd!<CR>', {'silent': v:true})
  call nvim_buf_set_keymap(buf, 'n', '<CR>', ':bd!<CR>', {'silent': v:true})
endfunction

function! RandomPickOnBufRead(...)
  let folder = expand('$HOME/.config/nvim/themes/BanGDream_vim_theme/Poppin/Poppin_background')
  let files = split(globpath(folder, '*'), '\n')
  let count = len(files)

  if count == 0
    echom "📂 目标文件夹为空"
    return
  endif

  let statefile = '/tmp/roselia_wallpaper_index'
  let index = 0

  " 如果存在记录文件，读取上次 index
  if filereadable(statefile)
    let index = str2nr(readfile(statefile)[0])
  endif

  if a:0 > 0
    if a:1 == 1
      let index = 0
      echom "🎭 回到默认背景: " . fnamemodify(files[index], ':t')
    elseif a:1 == 2
      let index = (index + 1) % count
      echom "➡️  下一张背景: " . fnamemodify(files[index], ':t')
    else
      let index = rand() % count
      echom "🎲 随机选中背景: " . fnamemodify(files[index], ':t')
    endif
  else
    let index = rand() % count
    echom "🎲 随机选中背景: " . fnamemodify(files[index], ':t')
  endif

  " 写入新的 index
  call writefile([string(index)], statefile)

  " 建立链接
  let picked = files[index]
  let link_cmd = 'ln -sf "' . picked . '" ~/.config/wezterm/background.jpg'
  call system(link_cmd)
endfunction
