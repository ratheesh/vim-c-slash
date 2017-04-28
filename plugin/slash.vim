function! Slash()
python << EOF
import vim

buffer = vim.current.buffer

start, _ = buffer.mark('<')
end, _ = buffer.mark('>')

for i in xrange(start - 1, end):
    buffer[i] = buffer[i].rstrip('\\ ')

maxLen = max(map(len, buffer[start-1:end]) or [0]) + 1

for i in xrange(start - 1, end):
    buffer[i] += ' ' * (maxLen - len(buffer[i])) + '\\'

EOF
endfunction

vnoremap <C-\> :<c-u>call Slash()<cr>