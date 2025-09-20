# ~/.config/fish/completions/ros2.fish

# 主命令补全：列出所有核心子命令
complete -c ros2 -n "__fish_use_subcommand" -a "bag component daemon doctor interface launch lifecycle node param pkg run security service topic action"

# --- daemon ---
complete -c ros2 -n "__fish_seen_subcommand_from daemon" -a "start stop status"

# --- component ---
complete -c ros2 -n "__fish_seen_subcommand_from component" -a "load composition list types"

# --- launch (补全launch文件) ---
complete -c ros2 -n "__fish_seen_subcommand_from launch" -k -a "(__fish_complete_suffix .launch.py)"
complete -c ros2 -n "__fish_seen_subcommand_from launch" -k -a "(__fish_complete_suffix .xml)"
# 补全包名（从简单脚本添加）
complete -c ros2 -n "__fish_seen_subcommand_from launch" -xa "(ros2 pkg list 2>/dev/null | grep launch | string replace '/launch.*' '' | string trim)"

# --- node ---
complete -c ros2 -n "__fish_seen_subcommand_from node" -a "list info"
complete -c ros2 -n "__fish_seen_subcommand_from node; and __fish_seen_subcommand_from info" -a "(ros2 node list 2>/dev/null | string trim)"

# --- param ---
complete -c ros2 -n "__fish_seen_subcommand_from param" -a "list get set delete load dump"
complete -c ros2 -n "__fish_seen_subcommand_from param; and __fish_seen_subcommand_from get set delete dump" -a "(ros2 node list 2>/dev/null | string trim)"

# --- pkg ---
complete -c ros2 -n "__fish_seen_subcommand_from pkg" -a "list create executables prefix"
# 补全包名
complete -c ros2 -n "__fish_seen_subcommand_from pkg; and __fish_seen_subcommand_from executables prefix" -a "(ros2 pkg list 2>/dev/null | string trim)"
# 从简单脚本添加的 pkg 子命令补全
complete -c ros2 -n "__fish_seen_subcommand_from pkg" -xa "create list prefixes" -d "Package command"

# --- run ---
# 补全包名
complete -c ros2 -n "__fish_seen_subcommand_from run" -a "(ros2 pkg list 2>/dev/null | string trim)"
# 补全可执行文件（基于包名）
complete -c ros2 -n "__fish_seen_subcommand_from run; and __fish_seen_subcommand_from (ros2 pkg list 2>/dev/null | string trim)" -a "(ros2 pkg executables (commandline -t | string split ' ')[2] 2>/dev/null)"
# 从简单脚本添加的 run 补全
complete -c ros2 -n "__fish_seen_subcommand_from run" -xa "(ros2 pkg list | xargs -I {} bash -c 'ros2 pkg executables {} | cut -d\\  -f2' 2>/dev/null)" -d "Executable"

# --- service ---
complete -c ros2 -n "__fish_seen_subcommand_from service" -a "list call type find"
complete -c ros2 -n "__fish_seen_subcommand_from service; and __fish_seen_subcommand_from call type" -a "(ros2 service list 2>/dev/null | string trim)"

# --- topic ---
complete -c ros2 -n "__fish_seen_subcommand_from topic" -a "list echo pub hz info type find delay"
complete -c ros2 -n "__fish_seen_subcommand_from topic; and __fish_seen_subcommand_from echo pub hz info type" -a "(ros2 topic list 2>/dev/null | string trim)"

# --- action ---
complete -c ros2 -n "__fish_seen_subcommand_from action" -a "list info"
complete -c ros2 -n "__fish_seen_subcommand_from action; and __fish_seen_subcommand_from info" -a "(ros2 action list 2>/dev/null | string trim)"

# --- bag ---
complete -c ros2 -n "__fish_seen_subcommand_from bag" -a "record play info list reindex"

# --- security ---
complete -c ros2 -n "__fish_seen_subcommand_from security" -a ""

# --- multicast ---
complete -c ros2 -n "__fish_seen_subcommand_from multicast" -a ""

# --- doctor ---
complete -c ros2 -n "__fish_seen_subcommand_from doctor" -a ""

# --- interface ---
complete -c ros2 -n "__fish_seen_subcommand_from interface" -a ""

# --- lifecycle ---
complete -c ros2 -n "__fish_seen_subcommand_from lifecycle" -a ""

# --- 通用参数补全 (例如 --help) ---
complete -c ros2 -n "__fish_seen_subcommand_from daemon component launch node param pkg run service topic action bag security multicast doctor interface lifecycle" -l help -d "显示帮助信息"