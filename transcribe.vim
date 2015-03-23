" Script to improve transcribing audio/video in Vim: after loading this file,
" you can control mplayer through Vim commands. No need to switch between your
" Vim instance and the media player during your transcriptions
"

:command  -complete=file -nargs=1 Test :call Test( "<args>" )
function StartTranscribing( source )
    if filereadable( a:source )
	"create a new named pipe for communication between mplayer and vim
	let s:mppipe = tempname()
	let s:outfile = tempname()
	!mplayer "-quiet -slave -input file=$mppipe $source" > "$outfile"<CR><CR>
    else
	echo "Error reading file " . a:source
    endif

endfunction


" one argument with -nargs=1
:command -complete=file -nargs=1 StartTranscribing :call StartTranscribing( "<args>" )<CR><CR>

function StopTranscribing()
    !echo "quit" > $mppipe
    unlet s:mppipe
endfunction

" function to get the time
function GetMPlayerTime()
    system('echo "get_time_pos" > /tmp/mplayer.pipe')
    let time = system( 'tail -1  < /tmp/mplayer.out' )
    return substitute( time, '.*=', '' )
endfunction              

function Seek( time ) 
  !echo "seek $time" > $mppipe)
endfunction


imap <C-k> <Esc>:! echo "seek 10" > /tmp/mplayer.pipe<CR><CR>a
imap <C-l> <Esc>:! echo "seek 60" > /tmp/mplayer.pipe<CR><CR>a
imap <C-j> <Esc>:! echo "seek -10" > /tmp/mplayer.pipe<CR><CR>a
imap <C-h> <Esc>:! echo "seek -60" > /tmp/mplayer.pipe<CR><CR>a
imap <C-p> <Esc>:! echo "pause" > /tmp/mplayer.pipe<CR><CR>a
imap <C-t> <Esc>:! echo "get_time_pos" > /tmp/mplayer.pipe<CR><CR>:r !tail -1 < /tmp/mplayer.out<CR><CR>k18xkJx5la


map <C-k> <Esc>:! echo "seek 10" > /tmp/mplayer.pipe<CR><CR>a
map <C-l> <Esc>:! echo "seek 60" > /tmp/mplayer.pipe<CR><CR>a
map <C-j> <Esc>:! echo "seek -10" > /tmp/mplayer.pipe<CR><CR>a
map <C-h> <Esc>:! echo "seek -60" > /tmp/mplayer.pipe<CR><CR>a
map <C-p> <Esc>:! echo "pause" > /tmp/mplayer.pipe<CR><CR>a
map <C-t> <Esc>:! echo "get_time_pos" > /tmp/mplayer.pipe<CR><CR>:r !tail -1 < /tmp/mplayer.out <CR><CR>k18xkJx5l

" Inserting protocol elements
map <S-F5> o<turn person="#researcher" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko
map <S-F6> o<turn person="#pupil" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko
map <S-F7> o<turn person="#teacher" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko
imap <S-F5> <turn person="#researcher" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko
imap <S-F6> <turn person="#pupil" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko
imap <S-F7> <turn person="#teacher" time="<C-t>"><CR></turn><Esc>ko<p><CR></p><Esc>ko

map <C-a> o<p time="<C-t>"><CR></p><Esc>ko
imap <C-a> <p time="<C-t>"><CR></p><Esc>ko
map <C-n> o<remark><CR></remark><Esc>ko
imap <C-n> <remark></remark><Esc>9ha
