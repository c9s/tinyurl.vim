" TinyURL Plugin
"
" Author: Cornelius (林佑安)
" Date: 六  6/12 16:36:19 2010
"
fun! s:replaceURL(line)
  let line = a:line
  echo "Found:  " . line
  let url = matchstr( line , 'https\?://\S\{10,}' )
  echo "URL:    " . url
  let tiny = MakeTinyURL(url)
  return substitute( line , url , tiny , '' )
endf

fun! MakeTinyURL(url)
  let output = system("curl -s -k -q 'http://tinyurl.com/api-create.php?url=" . a:url . "'" )
  return output
endf

fun! MakeTinyURLRange(s,e)
  for i in range( a:s , a:e )
    let line = getline(i)
    if line =~ 'https\?://\S\{10,}'
      cal setline(i, s:replaceURL( line ))
    endif
  endfor
endf

fun! MakeTinyURLBuffer()
  cal MakeTinyURLRange(1, line('$'))
endf

fun! MakeTinyURLLine()
  cal MakeTinyURLRange( line('.') , line('.'))
endf

com! -nargs=1 Maketinyurl        :cal MakeTinyURL(<q-args>)
com!          Maketinyurlbuffer  :cal MakeTinyURLBuffer()
com!          Maketinyurlline    :cal MakeTinyURLLine()
com! -range   Maketinyurlrange   :cal MakeTinyURLRange()
