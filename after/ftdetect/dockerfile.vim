augroup dockerfile
    autocmd!
    autocmd BufRead,BufNewFile *.dockerfile set filetype=dockerfile
augroup END

augroup dockerfile
    autocmd!
    autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
augroup END
