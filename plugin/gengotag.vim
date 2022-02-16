if exists('g:gengotag_loaded')
  finish
endif
let g:gengotag_loaded = 1

let s:basepath = expand('<sfile>:p:h:h')
let s:bin = s:basepath . '/' . 'gengotag'

if !executable(s:bin)
  echom 'Please build `gengotag` first'
  finish
endif

function! s:gen(data, type, omitempty)
  let omit = ""
  if a:omitempty
    let omit = "-omitempty"
  endif
  let cmd = printf("%s -jsondata '%s' -type %s %s 2>/dev/null", s:bin, a:data, a:type, omit)
  " echom cmd

  let str = system(cmd)
  " echo str
  if str == ''
	echo "json 格式有误"
  else
      normal `<v`>gc
      execute "normal! `<v`>\<esc>"
      let save = @a
      let @a = str
      normal "ap
      " execute "normal! O\<esc>\"ap\<cr>"
      let @a = save
  endif
endfunction

nnoremap <leader>g :set operatorfunc=<SID>Jsong2Struct<cr>g@
vnoremap <leader>g :<c-u>call <SID>Jsong2Struct(visualmode())<cr>


function! s:Jsong2Struct(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    elseif a:type ==# 'V'
        normal! `<v`>y
    else
        return
    endif

    call <SID>gen(@@, 'json', "<bang>" == "!")

    let @@ = saved_unnamed_register
endfunction
