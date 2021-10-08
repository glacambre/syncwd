
if [[ ! -v chpwd_functions ]]; then
  chpwd_functions=()
fi

SYNCWD_PLUGIN_DIR="$(dirname "$0")"
function syncwd () {
  pwd="${(qqq)PWD}"
  nvim -u NONE -i NONE --headless --cmd "source $SYNCWD_PLUGIN_DIR/syncwd.vim" -c ":call Syncwd('$NVIM_LISTEN_ADDRESS', '$pwd', $$)"
}

chpwd_functions+=syncwd
