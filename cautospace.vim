"
"       Filename:  cautospace.vim
"
"    Description:  This vim extension creates libvirt required blank
"                  wrapping for symbols as well keywords such as 'if',
"                  'while' and 'else'.
"                  Only works for C/C++ code.
"                  See libvirt coding style requirement from
"                  https://libvirt.org/hacking.html
"
"   GVIM Version:  untested
"
"  Configuration:  There are some personal details which should be configured
"                   (see the files README.csupport and csupport.txt).
"                  Visit https://github.com/huaqiangwang/cautospace.git for more details
"
"         Author:  Wang Huaqiang
"          Email:  davidhqwang@gmail.com
"
"        Version:  0.0.1
"        Created:  2018-7-30
"        License:  Copyright (c) 2018, Wang Huaqiang
"                  This program is free software; you can redistribute it and/or
"                  modify it under the terms of the GNU General Public License as
"                  published by the Free Software Foundation, version 2 of the
"                  License.
"                  This program is distributed in the hope that it will be
"                  useful, but WITHOUT ANY WARRANTY; without even the implied
"                  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
"                  PURPOSE.
"                  See the GNU General Public License version 2 for more details.
"       Revision:  0.0.1 Initial Version
"
"------------------------------------------------------------------------------
"

function ReplaceSymbol()
    let g:newl = substitute(g:newl, '\s*=\s*', ' = ', 'g')
    let g:newl = substitute(g:newl, '\s*|\s*', ' \| ', 'g')
    let g:newl = substitute(g:newl, '\s*^\s*', ' ^ ', 'g')
    let g:newl = substitute(g:newl, '\s*+\s*', ' + ', 'g')
    let g:newl = substitute(g:newl, '\s*-\s*', ' - ', 'g')


    " disabled.
    " a more usual case is representing pointer related operation
    " which normally does not have a space following it
    "let g:newl = substitute(g:newl, '\s*\*\s*', ' * ', 'g')
    let g:newl = substitute(g:newl, '\s*%\s*', ' % ', 'g')

    "cursor(line('.'),1)
    "let match = search('\/\s*[\/|=]','',line(.))
    "if match == 0
    "    let g:newl = substitute(g:newl, '\s*\/\s*', ' / ', 'g')
    "endif
    let g:newl = substitute(g:newl, '\s*\/\s*', ' / ', 'g')
    let g:newl = substitute(g:newl, '\s*>\s*', ' > ', 'g')
    let g:newl = substitute(g:newl, '\s*<\s*', ' < ', 'g')
    let g:newl = substitute(g:newl, '\s*,\s*', ', ', 'g')
    let g:newl = substitute(g:newl, '\s*;\s*', '; ', 'g')

    " Remove blank spaces at the tail
    " Help pattern
    " for ^v ^m ^M ^V
    let g:newl = substitute(g:newl, '\;\s*$', ';', 'g')
    let g:newl = substitute(g:newl, '\,\s*$', ',', 'g')
    let g:newl = substitute(g:newl, '\V>\s\*\$', '>', 'g')
    let g:newl = substitute(g:newl, '\V<\s\*\$', '<', 'g')

    let g:newl = substitute(g:newl, '\s*=\s*=\s*', ' == ', 'g')
    let g:newl = substitute(g:newl, '\s*\*\s*=\s*', ' *= ', 'g')
    let g:newl = substitute(g:newl, '\s*+\s*=\s*', ' += ', 'g')
    let g:newl = substitute(g:newl, '\s*-\s*=\s*', ' -= ', 'g')
    let g:newl = substitute(g:newl, '\s*\/\s*=\s*', ' /= ', 'g')
    let g:newl = substitute(g:newl, '\s*|\s*=\s*', ' |= ', 'g')
    let g:newl = substitute(g:newl, '\s*^\s*=\s*', ' ^= ', 'g')
    let g:newl = substitute(g:newl, '\s*<\s*<\s*=\s*', ' <<= ', 'g')
    let g:newl = substitute(g:newl, '\s*>\s*>\s*=\s*', ' >>= ', 'g')
    let g:newl = substitute(g:newl, '\s*%\s*=\s*', ' %= ', 'g')
    let g:newl = substitute(g:newl, '\s*&\s*=\s*', ' \&= ', 'g')

    let g:newl = substitute(g:newl, '\s*&\s*\*\s*', ' */ ', 'g')

    let g:newl = substitute(g:newl, '\s*\/\s*\/\s*', '// ', 'g')

    let g:newl = substitute(g:newl, '\s*&\s*&\s*', ' \&\& ', 'g')
    let g:newl = substitute(g:newl, '\s*|\s*|\s*', ' \|\| ', 'g')

    let g:newl = substitute(g:newl, '\s*+\s*+\s*', '++', 'g')
    let g:newl = substitute(g:newl, '\s*-\s*-\s*', '--', 'g')
    let g:newl = substitute(g:newl, '\s*-\s*>\s*', '->', 'g')
    let g:newl = substitute(g:newl, '\s*<\s*-\s*', '<-', 'g')
endfunction

function ReplaceIf()
    " echomsg
    if  match(g:newl,     '\m^\s*if\s*\V(\.\*') != -1
        let g:newl = substitute(g:newl, '\s*if\s*', 'if ', 'g')
    endif
    if  match(g:newl, '\m^\s*whiles*\V(\.\*') != -1
        let g:newl = substitute(g:newl, '\s*while\s*', 'while ', 'g')
    endif
    if  match(g:newl, '\m^\s*for\s*\V(\.\*') != -1
        let g:newl = substitute(g:newl, '\s*for\s*', 'for ', 'g')
    endif
    if  match(g:newl, '\m^\s*switch\s*\V(\.\*') != -1
        let g:newl = substitute(g:newl, '\s*switch\s*', 'switch ', 'g')
    endif
endfunction

function ReplaceBrace()
    let g:newl = substitute(g:newl, '\s*{\s*', ' {', 'g')

    let g:newl = substitute(g:newl, '(\s*', '(','g')
    let g:newl = substitute(g:newl, '\s*)', ')','g')
endfunction

function! FormatLine(lnum)
    let g:newl = getline(a:lnum)
    if strlen(g:newl)==0
        return
    endif
    if g:newl == '' || match(g:newl, '"') != -1
        return
    endif
    if  match(g:newl, "'") != -1
        return
    endif

    if match(g:newl, '\/\*') != -1
        return
    endif
    if match(g:newl, '\*\/') != -1
        return
    endif

    call inputsave()
    call ReplaceSymbol()
    call ReplaceIf()
    call ReplaceBrace()
    g:newl = substitute(g:newl, '\s+$','','g')
    call inputrestore()
    call setline(a:lnum, g:newl)
endfunction

function! FormatLineCur()
    let lnum = line('.')
    call FormatLine(lnum)
    call feedkeys("\<ESC>^v$=",'n')
endfunction

function! EnterEnter()
    let lnum = line('.')
    if ((col('$') > 1) && (col('$')-1 ) != (col('.')))
        echom "Line: not at end pos"
        call feedkeys("\<ESC>li\<CR>\<ESC>k :call FormatLine(line('.'))\<CR>^v$=j",'n')
        call feedkeys(":call FormatLine(line('.'))\<CR>^v$=^i",'n')
        return
    endif
    call FormatLine(lnum)
    call feedkeys("\<ESC>^v$=$a\<CR>",'n')
endfunction

function! EnterBrace()
   " call FormatLineCur()
    call FormatLine(line('.'))
    call feedkeys("\<ESC>^v$=$a {\<CR>}\<ESC>O",'ni')
endfunction

function! Endofline()
    return (col('$')-1) == col('.')
endfunction

"Original map for {<CR is : @{<CR>}<Esc>O
let fileext=expand('%:e')
if fileext == "c" || fileext == "cpp" || fileext == "h" || fileext == "hpp"
    inoremap <buffer> <CR> <Esc>:call EnterEnter()<CR>
    inoremap <buffer> {<CR> <ESC>:call EnterBrace()<CR>
    "~/.vim/bundle/YouCompleteMe/autoload/youcompleteme.vim
    noremap <F8> <ESC>:call FormatLineCur()<CR>
endif

"The * in the :imap output gives it away: 
"This is a buffer-local mapping, so in order to unmap it,
"you also need to specify the <buffer> attribute:
"iunmap <buffer> <C-C>a
