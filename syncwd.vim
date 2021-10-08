

function Syncwd(addr, pwd, pid)
  let channel = sockconnect('pipe', a:addr, { 'rpc': v:true })
  let has_pid = '{k,v -> has_key(getbufinfo(nvim_win_get_buf(v))[0].variables, "terminal_job_pid") }'
  let wins_with_pid = 'filter(nvim_list_wins(), ' . has_pid . ')'
  let pid_matches = '{k,v -> nvim_buf_get_var(nvim_win_get_buf(v), "terminal_job_pid") == ' . a:pid . '}'
  let wins_matching_pid = 'filter(' . wins_with_pid . ',' . pid_matches . ')'
  let wins = rpcrequest(channel, 'nvim_eval', wins_matching_pid)
  for win in wins
    try
      call rpcrequest(channel, 'nvim_command', ':lua vim.api.nvim_win_call(' . win . ', function() vim.cmd("lcd " .. ' . a:pwd . ') end)')
    catch
      echo v:exception
    endtry
  endfor
  qall!
endfunction
