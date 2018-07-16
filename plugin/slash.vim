function! ToggleSlash()
python << EOF
import vim

buffer = vim.current.buffer

start, _ = buffer.mark('<')
end, _ = buffer.mark('>')
end-=1

cnt = 0
for i in range(start - 1, end):
    cnt += buffer[i].rstrip().endswith('\\')

for i in range(start - 1, end):
    buffer[i] = buffer[i].rstrip('\\ ')

if cnt < (end - start + 1) / 2:
    maxLen = max(map(len, buffer[start-1:end]) or [0]) + 1
    if maxLen < 78:
        maxLen = 78

    for i in range(start - 1, end):
        buffer[i] += ' ' * (maxLen - len(buffer[i])) + '\\'

EOF
endfunction

" call tabular align function if present to align backslashes
if exists('g:tabular_loaded')
    vnoremap <C-\> :<c-u>call ToggleSlash()<CR> \| :<c-u>Tabularize /\\$<CR>
else
    vnoremap <C-\> :<c-u>call ToggleSlash()<CR>
endif
